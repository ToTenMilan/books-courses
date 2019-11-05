# provide login and pass to js monit

use Rack::Auth::Basic, "Restricted Area" do |username, password|
  [username, password] == ['admin', 'abc123']
end # use

run Proc.new { |env| ['200', {'Content-Type' => 'text/html'}, ['get rack\'d']] }