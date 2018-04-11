require_relative 'renderer' # require BritishTextObject

bto = BritishTextObject.new('wanker', 100, 'bloody hell')

# instead of modifying whole class, modify only single instance
class << bto
  def color
    colour
  end

  def text
    string
  end

  def size_inches
    size_mm / 25.4
  end
end

puts bto.singleton_methods
