require './schedulable.rb'

class Mechanic
  include Schedulable
  def lead_days
    4
  end
  # ...
end

m = Mechanic.new
m.schedulable?(starting, ending)
# This Mechanic is not scheduled
#   between 2015-02-29 and 2015-09-10
#  => true