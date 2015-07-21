namespace :assets do
  desc 'Precompile assets'
  task :precompile do
    sh 'bundle exec jekyll build'
    sh 'cp _includes/loadCSS.min.js _site/assets/'
    sh 'sass -t compressed _assets/stylesheets/app.scss _site/assets/app.css'
    # sh 'tar -cvzf _site/assets/app.css.gz _site/assets/app.css'
  end
end

desc 'Deploy site to S3'
task :deploy do
  # alternative
  # aws s3 sync _site s3://www.heuro.net --region us-east-1 --cache-control 3153600
  sh 'aws s3 sync _site s3://www.heuro.net'
end

task :server do
  sh 'bundle exec puma config.ru'
end
