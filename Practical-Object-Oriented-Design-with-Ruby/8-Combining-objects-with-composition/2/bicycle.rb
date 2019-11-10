require_relative './parts/mountain_bike_parts.rb'
require_relative './parts/road_bike_parts.rb'

class Bicycle
  attr_reader :size, :parts
  def initialize(args={})
    @size       = args[:size]
    @parts      = args[:parts]
  end
  def spares
    parts.spares
  end
end

road_bike =
  Bicycle.new(
    size:  'L',
    parts: RoadBikeParts.new(tape_color: 'red'))
p road_bike.size    # -> 'L'
p road_bike.spares
# -> {:tire_size=>"23",
#     :chain=>"10-speed",
#     :tape_color=>"red"}
mountain_bike =
  Bicycle.new(
    size:  'L',
    parts: MountainBikeParts.new(rear_shock: 'Fox'))
p mountain_bike.size   # -> 'L'
p mountain_bike.spares
# -> {:tire_size=>"2.1",
#     :chain=>"10-speed",
#     :rear_shock=>"Fox"}