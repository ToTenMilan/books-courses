### promote common behavior to abstract class ####
# requirements:
# • Bicycles have a chain and a tire size.
# • All bicycles share the same default for chain.
# • Subclasses provide their own default for tire size.
# • Concrete instances of subclasses are permitted to ignore defaults and supply instance-specific values.
class Bicycle
  attr_reader :size     # <- promoted from RoadBike
  attr_reader :chain, :tire_size # extracted abstracion
  def initialize(args={})
    @size = args[:size] # <- promoted from RoadBike
    @chain      = args[:chain]     || default_chain
    @tire_size  = args[:tire_size] || default_tire_size
    post_initialize(args) # this method let future programmers to forget about `super`, but they have to implement `post_initialize`
  end
  def spares
    { tire_size:  tire_size,
      chain:      chain }
  end
  # hook for subclasses to override
  def local_spares
    {}
  end
  def default_chain       # <- common default
    '10-speed'
  end
  def default_tire_size
    raise NotImplementedError, "This #{self.class} cannot respond to: 'default_tire_size'"
  end
  def post_initialize(args)
    nil
    ### my proposition:
    # raise NotImplementedError, "Instead of overriding 'initialize', Implement 'post_initialize' method to specialize your subclass"
  end
end

class RoadBike < Bicycle
  attr_reader :tape_color
  def post_initialize(args)
    @tape_color = args[:tape_color]
  end
  def local_spares
    {tape_color: tape_color}
  end
  def default_tire_size   # <- subclass default
    '23'
  end
end

class MountainBike < Bicycle
  attr_reader :front_shock, :rear_shock
  def post_initialize(args)
    @front_shock = args[:front_shock]
    @rear_shock =  args[:rear_shock]
  end
  def local_spares
    {rear_shock:  rear_shock}
  end
  def default_tire_size
    '2.1'
  end
end

road_bike = RoadBike.new(
              size:       'M',
              tape_color: 'red' )
p road_bike.size  # => "M"
p road_bike.spares
p road_bike.tire_size
p road_bike.chain

mountain_bike = MountainBike.new(
                  size:         'S',
                  front_shock:  'Manitou',
                  rear_shock:   'Fox')
p mountain_bike.size
p mountain_bike.spares
p mountain_bike.tire_size
p mountain_bike.chain

# One year later, adding new bike
class RecumbentBike < Bicycle
  attr_reader :flag
  def post_initialize(args)
    @flag = args[:flag]
  end
  def local_spares
    {flag: flag}
  end
  def default_chain
    "9-speed" # ???
  end
  def default_tire_size
    '28'
  end
end
bent = RecumbentBike.new(flag: 'tall and orange')
p 'recum'
p bent.spares
p bent.local_spares
### worng output in book
# "recum"
# {:tire_size=>"28", :chain=>"9-speed"}
# {:flag=>"tall and orange"}
