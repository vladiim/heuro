# Running locally

* Binstubs: `bundle install --binstubs`

* Start server: `bundle exec puma config.ru`

***

# Compile assets

* As a guard watcher: `bundle exec guard`

* As a once off: `rake assets:precompile`

***

# Deploy

* Deploy to S3: `rake deploy`

***