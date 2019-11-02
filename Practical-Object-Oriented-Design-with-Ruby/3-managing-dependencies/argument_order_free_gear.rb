# more verbose, but more resistant to changes initializer
class Gear
  attr_reader :chainring, :cog, :wheel
  def initialize(args)
    @chainring = args[:chainring]
    @cog       = args[:cog]
    @wheel     = args[:wheel]
  end
  ...
end

Gear.new(
  :chainring => 52,
  :cog       => 11,
  :wheel     => Wheel.new(26, 1.5)).gear_inches


######################################
# class Gear
#   attr_reader :chainring, :cog, :wheel
#   def initialize(chainring, cog, wheel)
#     @chainring = chainring
#     @cog       = cog
#     @wheel     = wheel
#   end
#   ...
# end

# # this initialize need to know in what order argumetns should be put. Its cumbersome on changes, especially on early stage
# Gear.new(
#   52,
#   11,
#   Wheel.new(26, 1.5)).gear_inches