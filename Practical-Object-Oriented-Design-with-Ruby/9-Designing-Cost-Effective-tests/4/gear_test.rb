require 'minitest/spec'
require 'minitest/autorun'
require_relative './gear.rb'

class GearTest < MiniTest::Unit::TestCase
  def setup
    @observer = MiniTest::Mock.new
    @gear     = Gear.new(
                  chainring: 52,
                  cog:       11,
                  observer:  @observer)
  end
  def test_notifies_observers_when_cogs_change
    # expect what should be received
    @observer.expect(:changed, true, [52, 27]) # check whether observer was nitified of change (observer is mocked)
    # trigger behavior
    @gear.set_cog(27)
    # verify
    @observer.verify
  end
  def test_notifies_observers_when_chainrings_change
    @observer.expect(:changed, true, [42, 11])
    @gear.set_chainring(42)
    @observer.verify
  end
end