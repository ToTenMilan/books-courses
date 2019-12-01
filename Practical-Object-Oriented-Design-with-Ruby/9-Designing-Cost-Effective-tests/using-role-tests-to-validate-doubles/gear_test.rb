require 'minitest/spec'
require 'minitest/autorun'
require_relative './diameterizable_interface_test.rb'
require_relative './gear.rb'

class DiameterDouble
  def width
    10
  end
end
# Prove the test double honors the interface this
#   test expects.
class DiameterDoubleTest < MiniTest::Unit::TestCase
  include DiameterizableInterfaceTest
  def setup
    @object = DiameterDouble.new
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