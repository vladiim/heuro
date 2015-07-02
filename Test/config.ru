# Rack config file.

system("pkill -9 ruby")

system("aws-flow-ruby -f worker.json&")

run Proc.new { |env| [200, {'Content-Type' => 'text/html'}, ['Done!']] }