require 'minitest/spec'
require 'minitest/autorun'
require_relative './diameterizable_interface_test.rb'
require_relative './gear.rb'

class WheelTest < MiniTest::Unit::TestCase
  include DiameterizableInterfaceTest
  def setup
    @wheel = @object = Wheel.new(26, 1.5)
  end

  def test_calculates_diameter
    wheel = Wheel.new(26, 1.5)
    assert_in_delta(29,
                    wheel.width,
                    0.01)
  end
end