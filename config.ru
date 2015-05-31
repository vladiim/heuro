require 'rack/contrib/try_static'
require 'rack/contrib/not_found'
 
use Rack::TryStatic,
  :root => "_site",
  :urls => %w[/],
  :try  => ['index.html', '/index.html']
 
Rack::Mime::MIME_TYPES.merge!({
  ".eot" => "application/vnd.ms-fontobject",
  ".ttf" => "font/ttf",
  ".otf" => "font/otf",
  ".woff" => "application/x-font-woff"
})
 
run Rack::NotFound.new('_site/404/index.html')