require 'rspec/mocks/standalone'


############ For pure doubles (mostly on greenfield code)

##### YIELDING MULTIPLE VALUES ######
extractor = double('TwitterURLExtractor')

pp allow(extractor).to receive(:extract_urls)
  .and_yield('https://rspec.info/', 11111111)
  .and_yield('https://github.com/', 22222222)
  .and_yield('https://pragprog.com/', 33333333) # => #<RSpec::Mocks::MessageExpectation #<Double "TwitterURLExtractor">.extract_urls(any arguments)>


##### RAISING EXCEPTIONS FLEXIBLY #####
# all three examples will work
allow(dbl).to receive(:msg).and_raise(AnExceptionClass)
allow(dbl).to receive(:msg).and_raise('an error message')
allow(dbl).to receive(:msg).and_raise(AnExceptionClass, 'with message')
exception_instance = AnExceptionClass.new
allow(dbl).to receive(:msg).and_raise(exception_instance)



############ For partial doubles (often when legacy code exists)

##### FALLING BACK TO THE ORIGINAL IMPLEMENTATION #####
# fake implementation for specific arguments (notice `with`)
allow(File).to receive(:read).with('/etc/passwd').and_raise('KEEP AWAY')

# fallback
allow(File).to receive(:read).and_call_original


##### MODIFYING THE RETURN VALUE #####
# testing exteranl API in acceptance tests, dont take all 1000000 records, take just 10
allow(CustomerService).to receive(:all).and_wrap_original do |original|
  all_customers = original.all
  all_customers.sort_by(&:id).take(10)
end

##### TWEAKING ARGUMENTS #####
# when password hash is not a constant (so harder to get in tests)
allow(PasswordHash).to receive(:hash_password)
  .and_wrap_original do |original, cost_factor|
    original.call(1)
  end

##### WHEN YOU NEED MORE FLEXIBILITY #####
# i.e. simulating intermittent network failure
counter = 0
allow(weather_api).to receive(:temperature) do |zip_code|
  counter = (counter + 1) % 4
  counter.zero? ? raise(Timeout::Error) : 35.0
end
