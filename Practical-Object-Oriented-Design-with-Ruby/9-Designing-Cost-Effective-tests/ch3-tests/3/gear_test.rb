require 'minitest/spec'
require 'minitest/autorun'
require_relative './gear.rb'

# Create a player of the 'Diameterizable' role (to make test faster and cheaper)
class DiameterDouble
  def diameter
    10
  end
end

class GearTest < MiniTest::Unit::TestCase
  def test_calculates_gear_inches
     gear =  Gear.new(
               chainring: 52,
               cog:       11,
               wheel:     DiameterDouble.new)

     assert_in_delta(47.27,
                     gear.gear_inches,
                     0.01)
  end
end