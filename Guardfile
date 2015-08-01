# guard 'jekyll-plus', extensions: ['scss', 'coffee', 'json', 'html.erb', 'rb', 'md', 'html'] do
#   watch /.*/
#   ignore /^_site/
# end

guard :shell, ignore: /_site\/*/ do
  watch /.*/ do |m|
    m[0] + " has changed."
    `rake assets:precompile`
  end
end
