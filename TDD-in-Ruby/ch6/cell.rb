class Cell
  def initialize(location)
    @alive = true
    @x = location[0]
    @y = location[1]
  end

  def location
    Location.for(@x, @y)
  end

  def alive?
    @alive == true
  end

  def die
    @alive = false
  end
end
