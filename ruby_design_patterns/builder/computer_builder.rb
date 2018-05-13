require_relative 'computer'

class ComputerBuilder
  attr_reader :computer

  def initialize
    @computer = Computer.new
  end

  def memory_size=(size_in_gb)
    @computer.motherboard.memory_size = size_in_gb
  end
end


class DesktopBuilder < ComputerBuilder
  def initialize
    @computer = DesktopComputer.new
  end

  def display=(display)
    @computer.display = display
  end

  def add_hard_disk(size_in_gb=1000)
    @computer.drives << Drive.new(:hard_disk, size_in_gb, true)
  end
end


class LaptopBuilder < ComputerBuilder
  def initialize
    @computer = LaptopComputer.new
  end

  def display=(display)
    raise 'Laptop siplay must be lcd' unless display == :lcd
  end

  def add_hard_disk(size_in_gb=1000)
    @computer.drives << LaptopDrive.new(:hard_disk, size_in_gb, true)
  end
end

bld = DesktopBuilder.new
# bld.turbo
bld.memory_size = 8
bld.add_hard_disk

lpt = LaptopBuilder.new
lpt.memory_size = 8
lpt.add_hard_disk

p 'desktop'
p bld.inspect
p 'Laptop'
p lpt.inspect