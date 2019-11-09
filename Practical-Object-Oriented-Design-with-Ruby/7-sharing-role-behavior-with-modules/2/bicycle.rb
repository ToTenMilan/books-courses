require './schedulable.rb'

class Bicycle
  include Schedulable
  def lead_days
    1
  end
  # ...
end
require 'date'
starting = Date.parse("2015/09/04")
ending   = Date.parse("2015/09/10")
b = Bicycle.new
b.schedulable?(starting, ending)
# This Bicycle is not scheduled
#    between 2015-09-03 and 2015-09-10
#  => true