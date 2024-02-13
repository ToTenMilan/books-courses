# could be impoved here:
# the test name mentions a Cell, while there is no cell class (primitive obsession)

def test_after_adding_a_cell_the_world_is_not_empty
  world = World.new
  world.set_living_at(1, 1)
  assert_false world.empty?
end

# could be improved:

def test_after_adding_a_cell_the_world_is_not_empty
  world = World.new
  world.add(Cell.new(1, 1))
  assert_false world.empty?
end

# or better

def test_after_adding_a_cell_the_world_is_populated
  world = World.new
  world.add(Cell.new(1, 1))
  assert world.populated?
end

examples of doamin words:
overcrowded
lonely
burth
populated
empty
alive
dead
