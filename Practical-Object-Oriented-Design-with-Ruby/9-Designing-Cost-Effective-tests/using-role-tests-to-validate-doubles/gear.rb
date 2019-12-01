class Gear
  attr_reader :chainring, :cog, :wheel
  def initialize(args)
    @chainring = args[:chainring]
    @cog       = args[:cog]
    @wheel     = args[:wheel]
  end
  def gear_inches
      # The object in the'wheel' variable
      #   plays the 'Diameterizable' role.
    ratio * wheel.width
  end
  def ratio
    chainring / cog.to_f
  end
# ...
end

class Wheel
  attr_reader :rim, :tire
  def initialize(rim, tire)
    @rim       = rim
    @tire      = tire
  end
  def width   # <—— used to be 'diameter'
    rim + (tire * 2)
  end
# ...
end