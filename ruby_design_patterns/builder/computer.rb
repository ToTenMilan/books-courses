require_relative 'cpu'
require_relative 'drive'

class Computer
  attr_accessor :display, :motherboard
  attr_reader :drives

  def initialize(display=:crt, motherboard=Motherboard.new, drives=[])
    @display = display
    @motherboard = motherboard
    @drives = drives
  end
end

class DesktopComputer < Computer

end

class LaptopComputer < Computer
  def initialize(motherboard=Motherboard.new, drives=[])
    super(:lcd, motherboard, drives)
  end
end

# motherboard = Motherboard.new(TurboCPU.new, 1000)

# drives = []
# drives << Drive.new(:ssd, 250, true)
# drives << Drive.new(:hdd, 1000, true)

# computer = Computer.new(:lcd, motherboard, drives)

# p computer.inspect