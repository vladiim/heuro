---
layout: post
title: Reproducible research in R - analysis driven development
categories: blog
description:
---

It's hard to describe how amazing it is when you start using the [Ruby on Rails][ror] web framework. Within a few minutes you've got a blog up and running. Concerns are separated across a models, views and controllers. Routing and data management are abstracted beautifully and there's a place for everything. People have spent much time in designing a web development framework that just makes sense. The great thing about Rails is that it is opinionated and lets web developers do what they want - develop websites.

For a long time my team has felt the same pain in creating reproducible R research as pre Rails web developers. So we decided to create a [simple framework called repro][repro] that does enough to remove the key decisions and boilerplate work for data analysts creating reproducible research in R.

In this post we'll walk through a simple workflow example from scratch and discuss a concept my team has been using that we've been calling Research Driven Development.

[ror]:http://rubyonrails.org/

[repro]:https://github.com/vladiim/repro

***

## Key concepts

Before we dig into a tutorial it's important to point out the key idea currently behind repro.

**No magic.** Unlike Rails, there's no magic to repro - what you see is what you get. The main benefit behind repro is it helps workflow by separating key concerns within the data pipeline.

**Managable functions.** Functions are kept small so they are reusable and easy for people to understand.

**Seperation of concerns.** Data transformation functions are kept in the `./transform/` directory, all graphing functions are kept in `./graphs/` etc.

**Clear naming.** As you'll see, function names are prefixed with their data-pipeline behaviour. If we're loading sales we have the `load.sales` function, if we're graphing sales we have the `graph.sales` function etc.

***

## GA tutorial

For this tutorial we'll do analysis on a client's Google Analytics site data. This will allow us to explore a range of concepts within the framework.

***

## Set up repo and GA access

* From your command line, clone into the directory `https://github.com/vladiim/repro`

* Change the name of the directory and move into it `mv repro ga_tutorial && cd ga_tutorial`

We need to extract data from Google Analytics so we'll install the [rga][rga] package and add it to our `init.R` file:

[rga]:https://github.com/skardhamar/rga

```r
suppressMessages(local({
  library(rga)
  library(reshape)
  library(knitr)
  library(markdown)
  library(ggplot2)
  library(scales)
  library(dplyr)
  library(RColorBrewer)
}))
```

We'll also need the site ID to access site data. To get this I usually use Google's [Query Explorer][qex]. We'll add the id to a new file we create at the top-level of the directory called `env.R`.

[qex]:https://ga-dev-tools.appspot.com/query-explorer/

```r
# env.R

Sys.setenv(
  SITE_ID = XXXXXXXX
)
```

We then add the `env.R` file to `.gitignore` so the confidential value isn't shared when we upload our repository to our source control service. We can now add any secret variables to the `env.R` file without them being shared. To access the variable we create a global variable in our `init.R` file by calling the `setEnvVars()` function.

```r
# init.R

# Config env
setEnvVars()
SITE_ID = Sys.getenv('SITE_ID')
```

Finally we need to authenticate our Google Analytics account. This rga function opens up a browser window so we wrap it in a helper function so it only calls the first time the code is loaded.

```r
# init.R

if (!exists('ga')) rga.open('ga')
```

And we're set up! We can now extract data from GA in order to do our analysis. The flow is similar any time you need to connect to a third party (database, API etc) in order to extract data.

***

## Extract data

For our first piece of analysis we want to look at monthly site sessions and transactions. Our first step is to extract our data. To do this we'll create a `extract/sessionsTransactions.R` file and add an extraction method.

```r
# extract/sessionsTransactions.R

extract.sessionsTransactions <- function() {
  ga$getData(
    SITE_ID, '2014-01-01', '2015-06-01', batch = TRUE,
    metrics    = 'ga:sessions,ga:transactions',
    dimensions = 'ga:date'
  )
}

extractandSave.sessionsTransactions <- function() {
  d <- extract.sessionsTransactions()
  write.csv(d, 'data/sessionsTransactions.csv')
}
```

Now we need to extract and save the data. We start R in our console with `R` then load our `init.R` file with `source('init.R')`. Loading the `init.R` file loads all of the files in the framework's directories. Finally we call our extract and save function `sessionsTransactions()`. We should now have a file with data at `data/sessionsTransactions.csv`.

***

## Load data

First we load the csv.

```r
# load/sessionsTransactions.R

load.sessionsTransactions <- function() {
  read.csv('data/sessionsTransactions.csv', header = TRUE, sep = ',', stringsAsCharacters = FALSE)
}
```

When we evaluate the data in our console, we see that the date column is characters.

```bash
# console

> d <- load.sessionsTransactions()
> str(d)
'data.frame':	517 obs. of  3 variables:
 $ date        : chr  "2014-01-01" "2014-01-02" "2014-01-03" "2014-01-04" ...
 $ sessions    : num  111606 102199 101888 88161 86111 ...
 $ transactions: num  3235 2963 2954 2556 2496 ...
```

Let's fix that in our load function.

```r
# load/sessionsTransactions.R

load.sessionsTransactions <- function() {
  read.csv('data/sessionsTransactions.csv', header = TRUE, sep = ',', stringsAsCharacters = FALSE) %>%
    mutate(date = as.Date(date))
}
```

***

## Transform data

For our first graph we want to compare the monthly sessions and transactions. So we need to summarise the monthly data and melt the data frame into a long dataframe.

```r
# transform/sessionsTransactions.R

transform.sessionsTransactionsMonthly <- function() {
  d <- load.sessionsTransactions() %>%
    mutate(month = as.Date(format(date, '%Y-%m-1'))) %>%
    group_by(month) %>%
    summarise(sessions = sum(sessions), transactions = sum(transactions))
  mutate(data.frame(d), id = 'month')
}
```

***

## Graph data

We're going to create a straight-forward, stacked bar for our sessions and transactions data.

```r
# graphs/sessionsTransactions.R

graph.sessionsTransactionsMonthly <- function() {
  d <- load.sessionsTransactions()
  ggplot(d, aes(x = month, y = value, fill = variable)) +
    geom_bar(stat = 'identity')
}
```

{% image repro/sessions_transactions.png %}

***

## Create report

Finally we need to create our report. All our reporting is done in the (surprise) `./reports/` directory.

```bash

> tree reports
reports
├── helpers
│   └── report.R
├── output
│   ├── figures
│   │   └── NAexample-1.png
│   └── report.md
├── run.R
└── templates
    └── report.Rmd

4 directories, 5 files
```

Our functions to run reports are in `reports/run.R`. We only need to worry about this file if we're creating more than one report. Our knitr helpers are located in `reports/helpers/**` we'll get to these in a minute. Our reports are in `reports/templates/**`. Finally, our reports are generated in `reports/output/**`.

The file structure will make a lot more sense with an example so let's go in and set up our knitr helper. We want to add our sessionsTransactions graph to our report.

```r
# reports/helpers/report.R

## @knitr sessionsTransactions
source('../../init.R')
graph.sessionsTransactions()
```

Our knitr variable is made available with `## @knitr sessionsTransactions`. When we call `sessionsTransactions` in knitr the code below the variable definition is run. We include our sources files with `source('../../init.R')` and we call our function with `graph.sessionsTransactions()`.

Now we need to update our report.

```r
# reports/templates/report.Rmd

```{r echo=FALSE}
read_chunk('../helpers/report.R')
```

# Session transactions

* **Observation.**

    - There are less transactions than sessions

* **Take out.**

    - Only a small portion of sessions result in transactions

```{r echo = FALSE, fig.cap='Session transactions', sessionsTransactions}
```

We read in our helper file with `read_chunk('../helpers/report.R')` and we generate our graph with `read_chunk('../helpers/report.R')`. The report is written in [markdown][markdown] with R flavor. To process all the R code within our `Rmd` file we need to call the function in `reports/run.R`.

```bash
> runReport()
processing file: ./reports/templates/report.Rmd
  |....                                                             |   6%
label: unnamed-chunk-1 (with options)
List of 1
 $ echo: logi FALSE

  |........                                                         |  12%

output file: ./reports/output/report.md
```

We can see that our output file is in `./reports/output/report.md`, knitr has processed all our R code, stored the graphs as images in `./reports/output/figures/**` and referenced the image in the relevant spot in the `./reports/output/report.md` file.

Now that we have our report `./reports/output/report.md` we can turn it into html, Microsoft Word docx, LaTaX, PDF and many other formats with [pandoc][pandoc]. We tend to deliver our reports in Microsoft Word, pandoc allows us to give it reference files so we can ensure our report maintains our business' look and feel.

```bash
> pandoc reports/output/report.md -o /Users/username/Desktop/myreport.docx --reference-docx /tmp/work_template.docx
```

Our first argument is our generated report, we give `-o` or, output, the output file we want pandoc to generate - pandoc knows what type of file to generate based on the extension we give it. Finally we pass pandoc a reference Word document. You can download the document referenced above [here][template].

[template]:http://www.heuro.net/assets/templates.docx

[markdown]:http://daringfireball.net/projects/markdown/

[pandoc]:http://pandoc.org/

[knitr]:http://yihui.name/knitr/

***

# Analysis driven development

Know you know the workflow, we can discuss an idea we use called "Research Driven Development" or RDD. As with the Rails example given at the begin of this article, we steal a concept from software development, "Test Driven Development" or TDD and repurpose it for our data analysis needs.

In TDD software developers write unit tests prior to writing their code. The test therefore help the developer think about the end outcome and thereby are a design tool

In RDD the data analyst writes out the report she expects prior to writing the code to generate the report. In essence, we reverse our workflow. In the example above, we would start by writing a function in our `reports/templates/report.Rmd` file and work our way backwards to extracting our data in `extract/sessionsTransactions.R`.
