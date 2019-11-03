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
  end
  def spares
    { tire_size:  tire_size,
      chain:      chain }
  end
  def default_chain       # <- common default
    '10-speed'
  end
  def default_tire_size
    raise NotImplementedError, "This #{self.class} cannot respond to: 'default_tire_size'"
  end
  def post_initialize(args)
    nil
  end
end

class RoadBike < Bicycle
  attr_reader :tape_color
  def initialize(args)
    @tape_color = args[:tape_color]
    super(args)  # <- RoadBike now MUST send 'super'
  end
  def spares
    super.merge({tape_color: tape_color})
  end
  def default_tire_size   # <- subclass default
    '23'
  end
end

class MountainBike < Bicycle
  attr_reader :front_shock, :rear_shock
  def initialize(args)
    @front_shock = args[:front_shock]
    @rear_shock  = args[:rear_shock]
    super(args)
  end
  def spares
    super.merge(rear_shock: rear_shock)
  end
  def default_tire_size   # <- subclass default
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
  def default_chain
    '9-speed'
  end
end

bent = RecumbentBike.new # <- `default_tire_size': NotImplementedError




### wrong implementation ###
# class MountainBike < Bicycle ### Bicycle class is disguised RoadBike class, so its not abstract class but concrete
#   attr_reader :front_shock, :rear_shock
#   def initialize(args)
#     @front_shock = args[:front_shock]
#     @rear_shock  = args[:rear_shock]
#     super(args)
#   end
#   def spares
#     super.merge(rear_shock: rear_shock)
#   end
# end

# mountain_bike = MountainBike.new(
#                   size:         'S',
#                   front_shock:  'Manitou',
#                   rear_shock:   'Fox')
# mountain_bike.size # -> 'S'
# mountain_bike.spares
# # -> {:tire_size   => "23",       <- wrong!
# #     :chain       => "10-speed",
# #     :tape_color  => nil,        <- not applicable
# #     :front_shock => 'Manitou',
# #     :rear_shock  => "Fox"}




### added code to differentiate between road style bike and other styles
# class Bicycle
#   attr_reader :style, :size, :tape_color,
#               :front_shock, :rear_shock
#   def initialize(args)
#     @type        = args[:style]
#     @size        = args[:size]
#     @tape_color  = args[:tape_color]
#     @front_shock = args[:front_shock]
#     @rear_shock  = args[:rear_shock]
#   end
#   # checking "style" starts down a slippery slope
#   def spares
#     if style == :road
#       { chain:        '10-speed',
#         tire_size:    '23',       # milimeters
#         tape_color:   tape_color }
#     else
#       { chain:        '10-speed',
#         tire_size:    '2.1',      # inches
#         rear_shock:   rear_shock }
#     end
#   end
# end

# bike = Bicycle.new(
#         style:        :mountain,
#         size:         'S',
#         front_shock:  'Manitou',
#         rear_shock:   'Fox')
# bike.spares
# -> {:tire_size   => "2.1",
#     :chain       => "10-speed",
#     :rear_shock  => 'Fox'}




### initial bicycle class ("road"). Only one Bike at that time so no need to specialize
# class Bicycle
#   attr_reader :size, :tape_color

#   def initialize(args)
#     @size       = args[:size]
#     @tape_color = args[:tape_color]
#   end
#   # every bike has the same defaults for
#   # tire and chain size

#   def spares
#     { chain:        '10-speed',
#       tire_size:    '23',
#       tape_color:   tape_color}
#   end
#   # Many other methods...
# end


# bike = Bicycle.new(
#         size:       'M',
#         tape_color: 'red' )
# bike.size     # -> 'M'
# bike.spares
# # -> {:tire_size   => "23",
# #     :chain       => "10-speed",
# #     :tape_color  => "red"}