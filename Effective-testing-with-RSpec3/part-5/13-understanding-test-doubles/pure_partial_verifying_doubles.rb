require 'rspec/mocks/standalone'

##### PARTIAL DOUBLES #######################
# For classes classes hardcoded deeply in code, not injected. Mostly for legacy, low quality code
class Random; end

# test
random = Random.new
pp allow(random).to receive(:rand).and_return(0.1234) # => #<RSpec::Mocks::MessageExpectation #<Random:0x0000559f7ad1d480>.rand(any arguments)>
pp random.rand # => 0.1234

# as a spy by using `allow`( no `spy` or `as_null_object` available)
pp allow(Dir).to receive(:mktmpdir).and_yield('/path/to/tmp') # => #<RSpec::Mocks::MessageExpectation #<Dir (class)>.mktmpdir(any arguments)>
Dir.mktmpdir { |dir| puts "Dir is: #{dir}" } # => Dir is: /path/to/tmp
expect(Dir).to have_received(:mktmpdir)

RSpec::Mocks.teardown



##### VERIFYING DOUBLES #####
# to help classes not go out of sync

# example of double without verification
ledger = double('ExpenseTracker::Ledger')
allow(ledger).to receive(:record) # if `record` will be renamed `record_expense`, test will still pass. Thats bad

# verifying double
ledger = instance_double('ExpenseTracker::Ledger')
allow(ledger).to receive(:record) # now, test will fail when `record` will be renamed


# instance_double(’SomeClass’)
#     Constrains the double’s interface using the instance methods of SomeClass

# class_double(’SomeClass’)
#     Constrains the double’s interface using the class methods of SomeClass

# object_double(some_object)
#     Constrains the double’s interface using the methods of some_object, rather than a class; handy for dynamic objects that use method_missing


##### STUBBED CONSTANTS #####
class PasswordHash
    COST_FACTOR = 12
end

# test dont need such expensive hashing
stub_const('PasswordHash::COST_FACTOR', 1)

# removing constant
hide_const('ActiveRecord') # for classes that not need AR in order to be tested