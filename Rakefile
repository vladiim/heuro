namespace :assets do
  desc 'Precompile assets'
  task :precompile do
    sh 'bundle exec jekyll build'
  end
end

desc 'Deploy site to S3'
task :deploy do
  # alternative
  # aws s3 sync _site s3://www.heuro.net --region us-east-1 --cache-control 3153600
  sh 'bundle exec s3_website push'
end