require 'minitest/spec'
require 'minitest/autorun'
require_relative './gear.rb'

class WheelTest < MiniTest::Unit::TestCase
  def setup
    @wheel = Wheel.new(26, 1.5)
  end
  def test_implements_the_diameterizable_interface
    assert_respond_to(@wheel, :diameter)
  end
  def test_calculates_diameter
    wheel = Wheel.new(26, 1.5)
    assert_in_delta(29,
                    wheel.diameter,
                    0.01)
  end
end