require 'minitest/spec'
require 'minitest/autorun'
require_relative './bicycle.rb'
require_relative './bicycle_interface_test.rb'
require_relative './bicycle_subclass_test.rb'

class StubbedBike < Bicycle
  def default_tire_size
    0
  end
  def local_spares
    {saddle: 'painful'}
  end
end

class BicycleTest < MiniTest::Unit::TestCase
  include BicycleInterfaceTest
  def setup
    @bike = @object = Bicycle.new({tire_size: 0})
    @stubbed_bike   = StubbedBike.new
  end
  def test_forces_subclasses_to_implement_default_tire_size
    assert_raises(NotImplementedError) {
      @bike.default_tire_size}
  end
  def test_includes_local_spares_in_spares
    assert_equal @stubbed_bike.spares,
                 { tire_size: 0,
                   chain:     '10-speed',
                   saddle:    'painful'}
  end
end

class StubbedBikeTest < MiniTest::Unit::TestCase
  include BicycleSubclassTest
  def setup
    @object = StubbedBike.new
  end
end