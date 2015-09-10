---
layout: post
title: Research driven development - reproducible research in R
categories: blog
description:
---

It's hard to describe how amazing it is when you start using the [Ruby on Rails][ror] web framework. Within a few minutes you've got a blog up and running. Concerns are separated across a models, views and controllers. Routing and data management are abstracted beautifully and there's a place for everything. People have spent much time in designing a web development framework that just makes sense. The great thing about Rails is that it is opinionated and lets web developers do what they want - develop websites.

For a long time my team has felt the same pain in creating reproducible R research as pre Rails web developers. So we decided to create a [simple framework called repro][repro] that does enough to remove the key decisions and boilerplate work for data analysts creating reproducible research in R.

In this post we'll walk through a simple workflow example from scratch and discuss a concept my team has been using that we've been calling Research Driven Development.

[ror]:http://rubyonrails.org/

[repro]:https://github.com/vladiim/repro

***

## No magic

Before we dig into a tutorial it's important to point out the key idea currently behind repro. Unlike Rails, there's no magic to repro - what you see is what you get. The main benefit behind repro is it helps workflow by separating key concerns within the data pipeline.

***

## GA tutorial

For this tutorial we'll do analysis on a client's Google Analytics site data. This will allow us to explore a range of concepts within the framework.

***

## Set up repo and GA access

* From your command line, clone into the directory `https://github.com/vladiim/repro`

* Change the name of the directory and move into it `mv repro ga_tutorial && cd ga_tutorial`

We need to extract data from Google Analytics so we'll install the [rga][rga] package and add it to our `init.R` file:

```
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

```
# env.R

Sys.setenv(
  SITE_ID = XXXXXXXX
)
```

We then add the `env.R` file to `.gitignore` so the confidential value isn't shared when we upload our repository to our source control service. We can now add any secret variables to the `env.R` file without them being shared. To access the variable we create a global variable in our `init.R` file by calling the `setEnvVars()` function.

```
# init.R

# Config env
setEnvVars()
SITE_ID = Sys.getenv('SITE_ID')
```

Finally we need to authenticate our Google Analytics account. This rga function opens up a browser window so we wrap it in a helper function so it only calls the first time the code is loaded.

```!r
# init.R

if (!exists('ga')) rga.open('ga')
```

And we're set up! We can now extract data from GA in order to do our analysis. The flow is similar any time you need to connect to a third party (database, API etc) in order to extract data.

***

## Extract data

For our first piece of analysis we want to look at monthly site sessions and transactions. Our first step is to extract our data. To do this we'll create a `extract/sessionsTransactions.R` file and add an extraction method.

```
# extract/sessionsTransactions.R

extract.sessionsTransactions <- function() {

}
```

[qex]:https://ga-dev-tools.appspot.com/query-explorer/

[rga]:https://github.com/skardhamar/rga
