require 'faraday'

conn = Faraday.new('https://twitter.com/search') do |faraday|
  faraday.response :logger
  faraday.adapter Faraday.default_adapter
  faraday.params['q'] = 'ruby'
  faraday.params["src"] = 'typd'
end

response = conn.get
p response.status


# gems/faraday-0.8.8/lib/faraday.rb
​module​ Faraday
  ​class​ << self
    ​def​ new(url = nil, options = {})
      ​# ...​
      Faraday::Connection.new(url, options, &block)
    ​end​
    ​# ...

# gems/faraday-0.8.8/lib/faraday/connection.rb
​module​ Faraday
  ​class​ Connection
    ​def​ initialize(url = nil, options = {})
      ​# ...​
      ​yield​ self ​if​ block_given?
      ​# ...​
    ​end​
    ​# ...