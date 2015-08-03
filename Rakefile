namespace :assets do
  desc 'Precompile assets'
  task :precompile do
    sh 'bundle exec jekyll build'
    sh 'cp _includes/loadCSS.min.js _site/assets/'
    sh 'sass -t compressed _assets/stylesheets/app.scss _site/assets/app.css'
    sh 'cp _assets/images/global/favicon.ico _site'
  end
end

desc 'Deploy site to S3'
task :deploy do
  sh 'aws s3 sync _site s3://www.heuro.net --cache-control 3153600'
end

task :server do
  sh 'bundle exec puma config.ru'
end
