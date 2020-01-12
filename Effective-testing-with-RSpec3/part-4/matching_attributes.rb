require 'uri'

uri = URI('http://github.com/rsepc/rspec')
expect(uri).to have_attributes(host: 'github.com', path: '/rspec/rspec')

# if you want to check only one attribute among many others:
expect([uri]).to include(an_object_having_attributes(host: 'github.com'))
