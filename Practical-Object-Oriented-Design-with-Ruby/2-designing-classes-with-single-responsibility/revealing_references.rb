class Gear
  attr_reader :chainring, :cog, :wheel
  def initialize(chainring, cog, wheel=nil)
    @chainring = chainring
    @cog       = cog
    @wheel     = wheel
  end
  def ratio
    chainring / cog.to_f
  end
  def gear_inches
    ratio * wheel.diameter
  end
end

class Wheel
  attr_reader :rim, :tire
  def initialize(rim, tire)
    @rim       = rim
    @tire      = tire
  end
  def diameter
    rim + (tire * 2)
  end
  def circumference
    diameter * Math::PI
  end
end

@wheel = Wheel.new(26, 1.5)
puts @wheel.circumference
# -> 91.106186954104
puts Gear.new(52, 11, @wheel).gear_inches
# -> 137.090909090909
puts Gear.new(52, 11).ratio
# -> 4.72727272727273


###############################3
# move calculating wheel diameter to nested Wheel class (easy to move out later to separate class)
# class Gear
#   attr_reader :chainring, :cog, :wheel
#   def initialize(chainring, cog, rim, tire)
#     @chainring = chainring
#     @cog       = cog
#     @wheel     = Wheel.new(rim, tire)
#   end
#   def ratio
#     chainring / cog.to_f
#   end
#   def gear_inches
#     ratio * wheel.diameter
#   end
#   Wheel = Struct.new(:rim, :tire) do
#     def diameter
#       rim + (tire * 2)
#     end
#   end
# end


############################
# class RevealingReferences
#   attr_reader :wheels
#   def initialize(data)
#     @wheels = wheelify(data)
#   end

#   def diameters
#     wheels.collect {|wheel|
#       wheel.rim + (wheel.tire * 2)}
#   end
#   # ... now everyone can send rim/tire to wheel

#   Wheel = Struct.new(:rim, :tire)
#   def wheelify(data)
#     data.collect {|cell|
#       Wheel.new(cell[0], cell[1])}
#   end
# end


########################
# wrong
# class ObscuringReferences
#   attr_reader :data
#   def initialize(data)
#     @data = data
#   end

#   def diameters
#     # 0 is rim, 1 is tire
#     data.collect {|cell|
#       cell[0] + (cell[1] * 2)}
#   end
#   # ... many other methods that index into the array
# end