require './schedulable.rb'

class Vehicle
  include Schedulable
  def lead_days
    3
  end
  # ...
end

v = Vehicle.new
v.schedulable?(starting, ending)
# This Vehicle is not scheduled
#   between 2015-09-01 and 2015-09-10
#  => true