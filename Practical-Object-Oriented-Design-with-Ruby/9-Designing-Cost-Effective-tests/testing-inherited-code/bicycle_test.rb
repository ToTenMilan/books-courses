require 'minitest/spec'
require 'minitest/autorun'
require_relative './bicycle.rb'
require_relative './bicycle_interface_test.rb'
require_relative './bicycle_subclass_test.rb'

class BicycleTest < MiniTest::Unit::TestCase
  include BicycleInterfaceTest
  def setup
    @bike = @object = Bicycle.new({tire_size: 0})
  end
  def test_forces_subclasses_to_implement_default_tire_size
    assert_raises(NotImplementedError) {@bike.default_tire_size}
  end
end
class RoadBikeTest < MiniTest::Unit::TestCase
  include BicycleInterfaceTest # If responds to all of these, Liskov subs. is not violated
  include BicycleSubclassTest
  def setup
    @bike = @object = RoadBike.new(tape_color: 'red')
  end
  def test_puts_tape_color_in_local_spares
    assert_equal 'red', @bike.local_spares[:tape_color]
  end
end
class MountainBikeTest < MiniTest::Unit::TestCase
  include BicycleInterfaceTest
  include BicycleSubclassTest
  def setup
    @bike = @object = MountainBike.new
  end
end