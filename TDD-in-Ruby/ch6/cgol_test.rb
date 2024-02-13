require 'minitest/autorun'
require_relative 'cell'
require_relative 'location'

class NeighborHood
  def initialize
    @grid = []
  end

  def tick
    @grid.each do |cell|
      lonely_or_over_crowded_cells_die(cell)
      reproduction_of(cell)
    end
  end

  def seed(cells)
    @grid = cells
  end

  def number_of_neighbors_for(cell)
    size = 0
    offsets = Location::OFFSETS
    offsets.each do |offset|
      size = count_cell(cell, offset, size)
    end
    size
  end

  private

  def count_cell(original, offset, size)
    neighbor = find_neighbor_cell(original, offset)
    size += 1 if neighbor
    size
  end

  def find_neighbor_cell(original, offset)
    neighbor_location = Location.add(original.location, offset)
    @grid.detect{|cell| cell.at?(neighbor_location)}
  end

  def lonely_or_over_crowded_cells_die(cell)
    neighbors_count = number_of_neighbors_for(cell)
    if neighbors_count != 2 or neighbors_count == 3
      cell.die
    end
  end

  def reproduction_of(cell)
    neighbors_count = number_of_neighbors_for(cell)
    if cell.dead? and neighbors_count == 3
      cell.born
    end
  end

  def find_cell(location)
    @grid.detect {|c| c.location == location}
  end
end

nh = NeighborHood.new
nh.seed([
  Cell.new(Location::CENTER),
  Cell.new(Location::NORTH),
  Cell.new(Location::NORTHWEST),
  Cell.new(Location::SOUTHEAST)
])

10.times do
  nh.tick
  p nh
end

describe NeighborHood do
  it 'neighborhood with one alive cell will die in the next generation' do
    cell = Cell.new(Location::CENTER)
    c2 = Cell.new(Location::NORTH)
    neighborhood = NeighborHood.new
    neighborhood.seed([cell, c2])

    neighborhood.tick

    assert cell.dead?, 'Cell is still alive'
  end

  it 'a cell with two alive cells as neighbors will stay alive in the next generation' do
    c1 = Cell.new(Location::CENTER)
    c2 = Cell.new(Location::NORTH)
    c3 = Cell.new(Location::SOUTH)
    neighborhood = NeighborHood.new
    neighborhood.seed([c1,c2, c3])

    neighborhood.tick

    assert c1.alive?
  end

  it 'number of neighbors is 0 for a cell that is lonely' do
    c1 = Cell.new(Location::CENTER)
    neighborhood = NeighborHood.new
    neighborhood.seed([c1])

    assert_equal 0, neighborhood.number_of_neighbors_for(c1)
  end

  it 'number of neighbors is 1 for a cell that has a neighbor in north' do
    c1 = Cell.new(Location::CENTER)
    c2 = Cell.new(Location::NORTH)
    neighborhood = NeighborHood.new
    neighborhood.seed([c1, c2])

    assert_equal 1, neighborhood.number_of_neighbors_for(c1)
  end

  it 'number of neighbors is 2 for a cell that has a neighbor in north and south' do
    c1 = Cell.new(Location::CENTER)
    c2 = Cell.new(Location::NORTH)
    c3 = Cell.new(Location::SOUTH)
    neighborhood = NeighborHood.new
    neighborhood.seed([c1, c2, c3])

    assert_equal 2, neighborhood.number_of_neighbors_for(c1)
  end

  it 'number of neighbors is 2 for a north west cell that has a neighbor in north and west' do
    c1 = Cell.new(Location::NORTHWEST)
    c2 = Cell.new(Location::NORTH)
    c3 = Cell.new(Location::WEST)
    neighborhood = NeighborHood.new
    neighborhood.seed([c1, c2, c3])
    assert_equal 2, neighborhood.number_of_neighbors_for(c1)
  end

  it 'number of neighbors is 8 for a center cell that has a neighbor in all locations' do
    c1 = Cell.new(Location::CENTER)
    c2 = Cell.new(Location::NORTH)
    c3 = Cell.new(Location::SOUTH)
    c4 = Cell.new(Location::EAST)
    c5 = Cell.new(Location::WEST)
    c6 = Cell.new(Location::NORTHWEST)
    c7 = Cell.new(Location::NORTHEAST)
    c8 = Cell.new(Location::SOUTHWEST)
    c9 = Cell.new(Location::SOUTHEAST)

    neighborhood = NeighborHood.new
    neighborhood.seed([c1, c2, c3, c4, c5, c6, c7, c8, c9])

    assert_equal 8, neighborhood.number_of_neighbors_for(c1)
  end

  it 'number of neighbors is 3 for a north west cell that has a neighbor in north, west and center' do
    c1 = Cell.new(Location::NORTHWEST)
    c2 = Cell.new(Location::NORTH)
    c3 = Cell.new(Location::WEST)
    c4 = Cell.new(Location::CENTER)
    neighborhood = NeighborHood.new
    neighborhood.seed([c1, c2, c3, c4])

    assert_equal 3, neighborhood.number_of_neighbors_for(c1)
  end

  it 'number of neighbors is 3 for a north east cell that has a neighbor in north, east and center' do
    c1 = Cell.new(Location::NORTHEAST)
    c2 = Cell.new(Location::NORTH)
    c3 = Cell.new(Location::EAST)
    c4 = Cell.new(Location::CENTER)
    neighborhood = NeighborHood.new
    neighborhood.seed([c1, c2, c3, c4])

    assert_equal 3, neighborhood.number_of_neighbors_for(c1)
  end

  it 'number of neighbors is 3 for a south west cell that has a neighbor in east, center and south' do
    c1 = Cell.new(Location::SOUTHWEST)
    c2 = Cell.new(Location::SOUTH)
    c3 = Cell.new(Location::WEST)
    c4 = Cell.new(Location::CENTER)
    neighborhood = NeighborHood.new
    neighborhood.seed([c1, c2, c3, c4])

    assert_equal 3, neighborhood.number_of_neighbors_for(c1)
  end

  it 'a cell with 4 alive cells will die of overcrowding' do
    c1 = Cell.new(Location::CENTER)
    c2 = Cell.new(Location::NORTH)
    c3 = Cell.new(Location::NORTHWEST)
    c4 = Cell.new(Location::WEST)
    c5 = Cell.new(Location::SOUTHWEST)
    neighborhood = NeighborHood.new
    neighborhood.seed([c1, c2, c3, c4, c5])

    neighborhood.tick

    assert c1.dead?
  end

  it 'a dead cell with three alive cells as neighbors will be born in the next generation' do
    c1 = Cell.new(Location::CENTER)
    c1.die
    c2 = Cell.new(Location::NORTH)
    c3 = Cell.new(Location::NORTHWEST)
    c4 = Cell.new(Location::NORTHEAST)
    neighborhood = NeighborHood.new
    neighborhood.seed([c1, c2, c3, c4])

    neighborhood.tick

    assert c1.alive?
  end

  it 'a cell with three alive cells as neighbors will stay alive in the next generation' do
    c1 = Cell.new(Location::CENTER)
    c2 = Cell.new(Location::NORTH)
    c3 = Cell.new(Location::SOUTH)
    c4 = Cell.new(Location::EAST)
    neighborhood = NeighborHood.new
    neighborhood.seed([c1, c2, c3, c4])

    neighborhood.tick

    assert c1.alive?
  end

  it 'check if a cell is dead when the number of neighbors is counted' do
    # c1 = Cell.new(Location::CENTER)
    # c1.die
    # neighborhood = NeighborHood.new
    # neighborhood.seed([c1])

    # assert_equal 0, neighborhood.number_of_neighbors_for(c1)
  end
end
