require 'forwardable'
require 'ostruct'

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

class Parts
  extend Forwardable
  def_delegators :@parts, :size, :each
  include Enumerable
  def initialize(parts)
    @parts = parts
  end
  def spares
    select {|part| part.needs_spare}
  end
end

module PartsFactory
  def self.build(config, parts_class = Parts)
    parts_class.new(
      config.collect {|part_config|
        create_part(part_config)})
  end
  def self.create_part(part_config)
    OpenStruct.new(
      name:        part_config[0],
      description: part_config[1],
      needs_spare: part_config.fetch(2, true))
  end
end

road_config =
  [['chain',        '10-speed'],
   ['tire_size',    '23'],
   ['tape_color',   'red']]
mountain_config =
  [['chain',        '10-speed'],
   ['tire_size',    '2.1'],
   ['front_shock',  'Manitou', false],
   ['rear_shock',   'Fox']]

p 'Parts:'
road_parts = PartsFactory.build(road_config)
# -> [#<Part:0x00000101825b70
#       @name="chain",
#       @description="10-speed",
#       @needs_spare=true>,
#     #<Part:0x00000101825b20
#       @name="tire_size",
#          etc ...
p road_parts
mountain_parts = PartsFactory.build(mountain_config)
# -> <Parts:0x000001009ad8b8 @parts=
#      [#<OpenStruct name="chain",
#                    description="10-speed",
#                    needs_spare=true>,
#       #<OpenStruct name="tire_size",
#                    description="2.1",
#                    etc ...
p mountain_parts

p 'Bikes:'
road_bike =
  Bicycle.new(
    size: 'L',
    parts: PartsFactory.build(road_config))
p road_bike.spares
# -> [#<OpenStruct PartsFactory::Part name="chain", etc ...
mountain_bike =
  Bicycle.new(
    size: 'L',
    parts: PartsFactory.build(mountain_config))
p mountain_bike.spares
# -> [#<OpenStruct PartsFactory::Part name="chain", etc ...

recumbent_config =
  [['chain',        '9-speed'],
   ['tire_size',    '28'],
   ['flag',         'tall and orange']]

recumbent_bike =
  Bicycle.new(
    size: 'L',
    parts: PartsFactory.build(recumbent_config))
p recumbent_bike.spares
# -> [#<OpenStruct PartsFactory::Part
#       name="chain",
#       description="9-speed",
#       needs_spare=true>,
#     #<OpenStruct PartsFactory::Part
#       name="tire_size",
#       description="28",
#       needs_spare=true>,
#     #<OpenStruct PartsFactory::Part
#       name="flag",
#       description="tall and orange",
#       needs_spare=true>]