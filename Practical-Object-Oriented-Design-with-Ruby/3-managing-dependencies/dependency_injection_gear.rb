##### alternatives to dependency injection (but still too coupled), if one is constrained that Di cant be done
# 1.
# class Gear
#   attr_reader :chainring, :cog, :rim, :tire
#   def initialize(chainring, cog, rim, tire)
#     @chainring = chainring
#     @cog       = cog
#     @wheel     = Wheel.new(rim, tire)
#   end
#   def gear_inches
#     ratio * wheel.diameter
#   end
# # ...
# end

# 2.
# class Gear
#   attr_reader :chainring, :cog, :rim, :tire
#   def initialize(chainring, cog, rim, tire)
#     @chainring = chainring
#     @cog       = cog
#     @rim       = rim
#     @tire      = tire
#   end
#   def gear_inches
#     ratio * wheel.diameter
#   end
#   def wheel
#     @wheel ||= Wheel.new(rim, tire)
#   end
# # ...
# end


######## DEPENDENCY INJECTION example ##################
# "wheel" dependency is injected by initializing Gear with Wheel instance
class Gear
  attr_reader :chainring, :cog, :wheel
  def initialize(chainring, cog, wheel)
    @chainring = chainring
    @cog       = cog
    @wheel     = wheel
  end
  def gear_inches
    ratio * wheel.diameter
  end
# ...
end
# Gear expects a 'Duck' that knows 'diameter'
Gear.new(52, 11, Wheel.new(26, 1.5)).gear_inches


######## this code is too coupled #################################
# class Gear
#   attr_reader :chainring, :cog, :rim, :tire
#   def initialize(chainring, cog, rim, tire)
#     @chainring = chainring
#     @cog       = cog
#     @rim       = rim
#     @tire      = tire
#   end
#   # 4 dependencies here
#   # 1. name of class
#   # 2. expect Gear instance to respond to `diameter`
#   # 3. argmuents that Wheel require
#   # 4. order of arguments
#   def gear_inches
#     ratio * Wheel.new(rim, tire).diameter
#   end
#   def ratio
#     chainring / cog.to_f
#   end
# # ...
# end

# class Wheel
#   attr_reader :rim, :tire
#   def initialize(rim, tire)
#     @rim       = rim
#     @tire      = tire
#   end
#   def diameter
#     rim + (tire * 2)
#   end
# # ...
# end

# p Gear.new(52, 11, 26, 1.5).gear_inches