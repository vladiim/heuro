# Running locally

* Binstubs: `bundle install --binstubs`

* Start server: `./bin/puma config.ru`

* Run guard: `bundle exec guard`

***

# Compile assets

* Build _site: `rake assets:precompile`

***

# Deploy

* Deploy to S3: `./publish.sh`

***