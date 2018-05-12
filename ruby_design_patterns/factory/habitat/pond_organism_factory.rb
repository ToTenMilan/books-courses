require_relative 'frog'
require_relative 'algae'

class PondOrganismFactory # factory method (concrete factory)
  def new_animal(name)
    Frog.new(name)
  end
  def new_plant(name)
    Algae.new(name)
  end
end