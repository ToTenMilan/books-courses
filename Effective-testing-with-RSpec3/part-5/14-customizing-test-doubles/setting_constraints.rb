require 'rspec/mocks/standalone'


##### CONSTRAINING ARGUMENTS #####
movie = double('Jaws')
expect(movie).to receive(:record_review).with('Great movie!')
# movie.record_review('Bad')
# expected: ("Great movie!")
#      got: ("Bad")


##### ARGUMENT PLACEHOLDERS #####
# if you only care about one argument, among many arguments
cart = double
expect(cart).to receive(:add_product).with('Hoodie', anything, anything)
expect(cart).to receive(:add_product).with('Hoodie', any_args) # shorthand of above
cart.add_product('Hoodie', 'yolo', 'bang')
# counterpart
database = double
expect(database).to receive(:delete_all_records).with(no_args)

##### Hashes and keyword arguments #####
# APIs before Ruby 2.0 often allow to pass options hash, i.e.:
class BoxOffice
  def find_showtime(options)

  end
end

box_office = BoxOffice.new
box_office.find_showtime(movie: 'Jaws')
box_office.find_showtime(movie: 'Jaws', zip_code: 97204)
box_office.find_showtime(movie: 'Jaws', city: 'Portland', state: 'OR')
# specify only keys you care about by using 'hash_including':
expect(box_office).to receive(:find_showtime).with(hash_including(movie: 'Jaws'))
# also works with keyword arguments


##### CUSTOM LOGIC #####
# sefining custom mathcer:
RSpec::Matchers.define :a_city_in_oregon do
  match { |options| options[:state] == 'OR' && options[:city] }
end
# pass above custom matcher to any `with` constraint
expect(box_office).to receive(:find_showtime).with(a_city_in_oregon)


##### CONSTRAINING HOW MANY TIMES A METHOD GETS CALLED #####
# circuit breaker, that is protecting the client
client = instance_double('NasdaqClient')
expect(client).to receive(:current_price).thrice.and_raise(Timeout::Error)
stock_ticker = StockTicker.new(client)
# hit many times, but should stop at third
100.times { stock_ticket.price('AAPL') }

# if more than 3 (there is nothing after `thrice`)
expect(client).to receive(:current_price).exactly(4).times

# if you care only about minimum and maximum
expect(client).to receive(:current_price).at_least(3).times
expect(client).to receive(:current_price).at_most(10).times

expect(client).to receive(:current_price).at_least(:once)
expect(client).to receive(:current_price).at_most(:thrice)


##### ORDERING #####
# if you need to enforce order of method calling, use `ordered`
expect(greeter).to receive(:hello).ordered
expect(greeter).to receive(:goodbye).ordered
# this will fail:
greeter.goodbye
greeter.hello
# hint: need of using `order` is a "code smell" of specs too coupled to one implementation
