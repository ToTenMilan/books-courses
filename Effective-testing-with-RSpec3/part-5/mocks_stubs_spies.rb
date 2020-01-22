require 'rspec/mocks/standalone'

#################################
##### GENERIC TEST DOUBLES ######
# ledger = double # => #<Double (anonymous)>
# pp ledger.record(an: :expense) # => #<Double (anonymous)> received unexpected message :record with ({:an=>:expense}) (RSpec::Mocks::MockExpectationError)

# ledger = double('Ledger')
# pp ledger.record(an: :expense)   # => #<Double "Ledger"> received unexpected message :record with ({:an=>:expense}) (RSpec::Mocks::MockExpectationError)


######################
##### STUBS ##########
http_response = double('HTTPResponse', status: 200, body: 'OK') # => #<Double "HTTPResponse">
pp http_response.status # => 200
pp http_response.body # => 'OK'

### alt
http_response = double('HTTPResponse') # => #<Double "HTTPResponse">
allow(http_response).to receive_messages(status: 200, body: 'OK')
pp http_response.status # => 200
pp http_response.body # => 'OK'

### alt 2
pp allow(http_response).to receive(:status).and_return(200) # => #<RSpec::Mocks::MessageExpectation #<Double "HTTPResponse">.status(any arguments)>
pp allow(http_response).to receive(:body).and_return('OK')  # => #<RSpec::Mocks::MessageExpectation #<Double "HTTPResponse">.body(any arguments)>

# caveat
pp http_response.status(:args, :are, :ignored) # => 200
pp http_response.body(:blocks, :are) { :ignored } # => 'OK'


##########################
##### MOCKS ##############
ledger = double('Ledger')
pp expect(ledger).to receive(:record) # => #<RSpec::Mocks::MessageExpectation #<Double "Ledger">.record(any arguments)>

# pp RSpec::Mocks.verify # (Double "Ledger").record(*(any args)) (RSpec::Mocks::MockExpectationError)
                        # expected: 1 time with any arguments
                        # received: 0 times with any argumens

pp expect(ledger).to_not receive(:reset) # => #<RSpec::Mocks::MessageExpectation #<Double "Ledger">.reset(any arguments)>
# failure because `reset` is not expected to be received
# pp ledger.reset # => (Double "Ledger").reset(no args) (RSpec::Mocks::MockExpectationError)
                    # expected: 0 times with any arguments
                    # received: 1 time


################################
##### NULL OBJECTS #############
yoshi = double('Yoshi').as_null_object
pp yoshi.eat(:apple) # => #<Double "Yoshi">
pp yoshi.eat(:apple).then_shoot(:shell).then_stomp # => #<Double "Yoshi">


###########################
##### SPIES ###############
class Game
  def self.play(character)
    character.jump
  end
end

# mario = double('Mario') # => #<Double "Mario">
# pp expect(mario).to receive(:jump) # => #<RSpec::Mocks::MessageExpectation #<Double "Mario">.jump(any arguments)>
# Game.play(mario)

### using null object to allow all methods
mario = double('Mario').as_null_object # => #<Double "Mario">
Game.play(mario) # mario needs to be null_object to not raise error
pp expect(mario).to have_received(:jump) # check whether `mario` received `jump`

### allowing method explicitly (using `receive` before and `have_received` after `Game.play`, defeats use of "spying")
mario = double('Mario') # => #<Double "Mario">
pp allow(mario).to receive(:jump) #<RSpec::Mocks::MessageExpectation #<Double "Mario">.jump(any arguments)>
Game.play(mario)
expect(mario).to have_received(:jump)

# `spy` ##########
mario = spy('Mario') #<Double "Mario">
# above is the same as:
# mario = double('Mario').as_null_object
Game.play(mario)
pp expect(mario).to have_received(:jump)



# All of the above are PURE DOUBLES. Best for code where dependencies can be passed in
#######################################################################################
