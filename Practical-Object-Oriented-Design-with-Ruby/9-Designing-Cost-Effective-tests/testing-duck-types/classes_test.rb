require 'minitest/spec'
require 'minitest/autorun'
require_relative './classes.rb'
require_relative './preparer_interface_test.rb'

class MechanicTest < MiniTest::Test
  include PreparerInterfaceTest # test whether class implements role (interface of preparer)
  def setup
    @mechanic = @object = Mechanic.new
  end
  # other tests which rely on @mechanic
end

class TripCoordinatorTest < MiniTest::Test
  include PreparerInterfaceTest
  def setup
    @trip_coordinator = @object = TripCoordinator.new
  end
end
class DriverTest < MiniTest::Test
   include PreparerInterfaceTest

   def setup
     @driver = @object =  Driver.new
   end
 end