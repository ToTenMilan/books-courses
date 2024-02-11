require 'minitest/autorun'
require_relative 'cell'
require_relative 'location'

describe Cell do
  it 'is alive when it is created' do
    cell = Cell.new(Location::CENTER)

    assert cell.alive?
  end

  it 'can transition to dead state' do
    cell = Cell.new(Location::CENTER)
    cell.die
    refute cell.alive?
  end

  it 'has a location' do
    cell = Cell.new(Location::NORTH)
    result = cell.location

    assert_equal Location::NORTH, result
  end
end
