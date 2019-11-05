require 'rack'

app = Proc.new do |env|
    ['200', {'Content-Type' => 'text/html'}, ['A barebones rack app.']]
end # Proc.new

Rack::Handler::WEBrick.run app