namespace :assets do
  desc 'Precompile assets'
  task :precompile do
    sh 'bundle exec jekyll build'
  end
end

des 'Deploy site to S3' do
  task :deploy_site do
    sh 'bundle exec s3_website push'
  end
end