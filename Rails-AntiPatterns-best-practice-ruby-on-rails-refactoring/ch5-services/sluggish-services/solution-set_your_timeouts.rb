# Default time out is too long.
# lower the timeout for unreliable services, and retry the task
# Note, to not lower below the actual task execution time

request = Net::HTTP::Post.new(url.path)
request.set_form_data({'xml' => xml})
http = Net::HTTP.new(url.host, url.post).start
http.read_timeout = 3 # default for Net::HTTP is 60 seconds
response = http.request(req)
