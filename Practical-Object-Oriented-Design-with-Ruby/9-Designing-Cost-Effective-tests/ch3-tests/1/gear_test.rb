require 'minitest/spec'
require 'minitest/autorun'
require_relative './classes.rb'

class GearTest < MiniTest::Unit::TestCase
  def test_calculates_gear_inches
    gear =  Gear.new(
              chainring: 52,
              cog:       11,
              rim:       26,
              tire:      1.5 )
    # gear_in_inches is using Wheel underneath,
    # so its vulnerable to change tests
    # if Wheel will change 
    assert_in_delta(137.1,
                    gear.gear_inches,
                    0.01)
  end
end
