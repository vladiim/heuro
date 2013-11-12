---
layout: post
title: How to build a hacker's blogging and drip marketing engine
tags: development
---

In this post I'll go through how I built a blogging and drip marketing app. I'll cover off my use case, the features I wanted, the tools I used and the code I wrote step-by-step. You'll need to have a working knowledge of Ruby and Git to fully understand all the code.

***

# Use case

I wanted to create this site to publish evergreen content on digital strategy. The aim of the content is to act as a guide for people to understand and apply digital strategy. 

focused on evergreen content delivered linearly for a curriculum
idea of site is to build audience w/ evergreen content and identify useful tool/product eventually that audience will pay for

***

# Features

write in markdown
site to load fast
sign up to newsletter
get sent articles in order they were written
good user analytics

***

# Blog generator

use jekyll

create  new jekyll app

{% highlight bash %}
  # shell terminal
  $ gem install jekyll
  $ jekyll new heuro
  $ cd heuro
{% endhighlight %}

get it on git

{% highlight bash %}
  # shell terminal
  $ git init
  $ git add . && git c -am "Initialised jekyll blog"
  $ git remote add origin git@github.com:vladiim/heuro.git
  $ git push -u origin master
{% endhighlight %}

***

# Hosting

heroku
cloudflare

jekyll's comes with a server but it isn't meant for production

add x & y to your Gemfile, puma: fast concurrent web server built on Ruby, Rack-Contrib gives us access to Rack Middleware.

{% highlight ruby %}
  # ./Gemfile
  gem 'rack-jekyll'
  gem 'puma'
  gem 'rack-contrib'
{% endhighlight %}

and run

{% highlight bash %}
  # shell terminal
  $ bundle install
{% endhighlight %}

we need a `config.ru` file to run rack `$ touch config.ru` then add

{% highlight ruby %}
  # ./config.ru
  require 'rack/contrib/try_static'
  require 'rack/contrib/not_found'
   
  use Rack::TryStatic,
    :root => "_site",
    :urls => %w[/],
    :try  => ['index.html', '/index.html']
   
  run Rack::NotFound.new('_site/404.html')
{% endhighlight %}

we also need a 404 page for our `config.ru` script to work `$ touch 404.html`

let's check to see if our puma server's working, make sure you've compile your static jekyll site `$ jekyll build` before starting puma

{% highlight bash %}
  # shell terminal
  $ puma config.ru
{% endhighlight %}

then open your browser to localhost:9393 and jekyll should be running

next set up heroku

heroku looks for a Procfile which tells it what type of process to run so we'll create the Procfile then a Heroku app. Note you'll need the [Heroku Toolbelt][heroku-toolbelt] in order to get the `heroku` CLI app.

[heroku-toolbelt]: https://toolbelt.heroku.com

{% highlight bash %}
  # shell terminal
  $ touch Procfile
  $ echo "web: bundle exec thin start -p $PORT -e $RACK_ENV" > Procfile
  $ heroku create
  $ git push heroku master
{% endhighlight %}

if you try to visit your heroku site it won't work because your static site hasn't been generated

in order to compile our site during the Heroku build we'll use the [Jekyll Assets][jekyll-assets] gem which adds similar functionality to Rails' Asset-Pipeline to our Jekyll app. First we add the jekyll-assets and an additional couple of gems that help with asset compilation to our Gemfile.

{% highlight ruby %}
  # ./Gemfile
  gem "jekyll-assets"
  gem "coffee-script"
  gem "compass"
  gem "uglifier"
  gem "sass"
{% endhighlight %}

Then run `$ bundle install`. Then we need Jekyll to include Jekyll Assets. We can do this through [Jekyll's plugin][jekyll-plugin] system. We require the gem in an assets.rb file in a newly created _plugins directory.

{% highlight bash %}
  # shell terminal
  $ mkdir _plugins
  $ touch _plugins/assets.rb
  $ echo "require 'jekyll-assets'" > _plugins/assets.rb
{% endhighlight %}

Jekyll Assets is super powerful and I really encourage you to play around with it. Finally we need Heroku to build our static site as part of its normal build process. Heroku will automatically run the `assets:precompile` task as part of the compilation process so we can hook into that.

First create a Rakefile

{% highlight bash %}
  # shell terminal
  $ touch Rakefile
{% endhighlight %}

Next add a new task to your Rakefile

{% highlight ruby %}
  # ./Rakefile
  namespace :assets do
    desc 'Precompile assets'
    task :precompile do
      sh "bundle exec jekyll build"
    end
  end
{% endhighlight %}

Finally we need to exclude some files from Jekyll to avoid some issues with running Jekyll on Heroku. Add the _config.yml file.

{% highlight yaml %}
  # ./_config.yaml
  exclude: [Gemfile, Gemfile.lock, Procfile, Rakefile, README.md] # etc etc
{% endhighlight %}

Make sure you also add any test posts to this array as your write them as they can also show up on your live site.

now our Jekyll site should build as it's pushing to heroku. If we open our Heroku URL we should see our site.

{% highlight bash %}
  # shell terminal
  $ heroku open
{% endhighlight %}

[jekyll-assets]: https://github.com/ixti/jekyll-assets
[jekyll-plugin]: http://jekyllrb.com/docs/plugins/

reference: http://mwmanning.com/2011/11/29/Run-Your-Jekyll-Site-On-Heroku.html
refernce2: http://jbhannah.net/blog/2013/01/16/jekyll-on-heroku-without-rack-jekyll-or-custom-buildpacks.html
***

# Email

***

# Images

***

