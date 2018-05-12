require_relative 'tiger'
require_relative 'tree'
require_relative 'frog'
require_relative 'algae'
require_relative 'waterlily'

class OrganismFactory
  def initialize(plant_class, animal_class)
    @plant_class = plant_class
    @animal_class = animal_class
  end
  def new_animal(name)
    @animal_class.new(name)
  end
  def new_plant(name)
    @plant_class.new(name)
  end
end