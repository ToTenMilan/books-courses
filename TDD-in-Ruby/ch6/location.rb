class Location
  NORTHWEST = [-1, 1]
  NORTHEAST = [1, 1]
  SOUTHWEST = [-1, -1]
  SOUTHEAST = [1, -1]
  CENTER    = [0, 0]
  NORTH     = [0, 1]
  SOUTH     = [0, -1]
  EAST      = [1, 0]
  WEST      = [-1, 0]

  def self.for(x, y)
    if x == 0 and y == 1
      NORTH
    elsif x == 0 and y == -1
      SOUTH
    elsif x == 1 and y == 0
      EAST
    elsif x == -1 and y == 0
      WEST
    elsif x == 0 and y == 0
      CENTER
    elsif x == -1 and y == 1
      NORTHWEST
    elsif x == 1 and y == 1
      NORTHEAST
    elsif x == 1 and y == -1
      SOUTHEAST
    elsif x == -1 and y == -1
      SOUTHWEST
    end
  end
end
