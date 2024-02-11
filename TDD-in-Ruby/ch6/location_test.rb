require 'minitest/autorun'
require_relative 'location'

describe Location do
  it 'NorthWest is located at (-1, 1)' do
    assert_equal [-1, 1], Location::NORTHWEST
  end
  it 'NorthEast is located at (1, 1)' do
    assert_equal [1, 1], Location::NORTHEAST
  end
  it 'SouthWest is located at (-1, -1)' do
    assert_equal [-1, -1], Location::SOUTHWEST
  end
  it 'SouthEast is located at (1, -1)' do
    assert_equal [1, -1], Location::SOUTHEAST
  end
  it 'Center is located at (0, 0)' do
    assert_equal [0, 0], Location::CENTER
  end
  it 'North is located at (0, 1)' do
    assert_equal [0, 1], Location::NORTH
  end
  it 'South is located at (0, -1)' do
    assert_equal [0, -1], Location::SOUTH
  end
  it 'East is located at (1, 0)' do
    assert_equal [1, 0], Location::EAST
  end
  it 'West is located at (-1, 0)' do
    assert_equal [-1, 0], Location::WEST
  end

  it 'location for 0, 1 is north' do
    location = Location.for(0, 1)

    assert_equal Location::NORTH, location
  end

  it 'location for -1, 1 is north west' do
    location = Location.for(-1, 1)
    assert_equal Location::NORTHWEST, location
  end

  it 'location for 1, 1 is north east' do
    location = Location.for(1, 1)
    assert_equal Location::NORTHEAST, location
  end

  it 'location for -1, -1 is south west' do
    location = Location.for(-1, -1)
    assert_equal Location::SOUTHWEST, location
  end

  it 'location for 1, 1 is south east' do
    location = Location.for(1, -1)
    assert_equal Location::SOUTHEAST, location
  end

  it 'location for 0, 1 is north' do
    location = Location.for(0, 1)
    assert_equal Location::NORTH, location
  end

  it 'location for 0, -1 is south' do
    location = Location.for(0, -1)
    assert_equal Location::SOUTH, location
  end

  it 'location for 1, 0 is south' do
    location = Location.for(1, 0)
    assert_equal Location::EAST, location
  end

  it 'location for -1, 0 is south' do
    location = Location.for(-1, 0)
    assert_equal Location::WEST, location
  end

  it 'location for 0, 0 is center' do
    location = Location.for(0, 0)
    assert_equal Location::CENTER, location
  end
end
