class Trip
  attr_reader :bicycles, :customers, :vehicle
  def prepare(preparers)
    preparers.each {|preparer|
      preparer.prepare_trip(self)}
  end
end

# Duck type classes, playing the 'Preparer' role
class Mechanic
  def prepare_trip(trip)
    trip.bicycles.each {|bicycle|
      prepare_bicycle(bicycle)}
  end
  # ...
end
class TripCoordinator
  def prepare_trip(trip)
    buy_food(trip.customers)
  end
  # ...
end
class Driver
  def prepare_trip(trip)
    vehicle = trip.vehicle
    gas_up(vehicle)
    fill_water_tank(vehicle)
  end
  # ...
end

###############################
# missing duck types problem here. Needs refactor to use duck types before writing tests
#
#class Trip
#  attr_reader :bicycles, :customers, :vehicle
#  def prepare(preparers)
#    preparers.each {|preparer|
#      case preparer
#      when Mechanic
#        preparer.prepare_bicycles(bicycles)
#      when TripCoordinator
#        preparer.buy_food(customers)
#      when Driver
#        preparer.gas_up(vehicle)
#        preparer.fill_water_tank(vehicle)
#      end
#    }
#  end
# end