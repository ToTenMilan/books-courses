require 'minitest/autorun'
require_relative 'cell'
require_relative 'location'

class NeighborHood
  def initialize
    @grid = []
  end

  def tick
    if @grid.size > 1

    else
      @grid.clear
    end
  end

  def alive_cells
    @grid.size
  end

  def seed(cells)
    @grid = cells
  end

  def number_of_neighbors_for(cell)
    size = 0
    if cell.location == Location::CENTER
      north_cell = @grid.detect {|c| c.location == Location::NORTH}
      south_cell = @grid.detect {|c| c.location == Location::SOUTH}

      if north_cell
        size += 1
      end
      if south_cell
        size += 1
      end
    elsif cell.location == Location::NORTHWEST
      north_cell = @grid.detect {|c| c.location == Location::NORTH}
      west_cell = @grid.detect {|c| c.location == Location::WEST}

      if north_cell
        size += 1
      end
      if west_cell
        size += 1
      end
    end
    size
  end
end

describe NeighborHood do
  it 'neighborhood with no alive cells will contain no alive cells in the next generation' do
    neighborhood  = NeighborHood.new
    neighborhood.tick

    alive_cells = neighborhood.alive_cells
    assert_equal 0, alive_cells
  end

  it 'neighborhood with one alive cell will die in the next generation' do
    cell = Cell.new(Location::CENTER)
    neighborhood = NeighborHood.new
    neighborhood.seed([cell])

    neighborhood.tick

    assert_equal 0, neighborhood.alive_cells
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
    NEXT code works only for center and northewest cells (refactor next)
    assert_equal 2, neighborhood.number_of_neighbors_for(c1)
  end
end
