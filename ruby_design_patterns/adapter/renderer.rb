class Renderer # client
  def self.render(text_object)
    text = text_object.text
    size = text_object.size_inches
    color = text_object.color
    [text, size, color]
  end
end

class TextObject # what renderer reders typically
  attr_reader :text, :size_inches, :color
  def initialize(text, size_inches, color)
    @text = text
    @size_inches = size_inches
    @color = color
  end
end

class BritishTextObject # Adaptee - what client needs to render this time
  attr_reader :string, :size_mm, :colour
  def initialize(string, size_mm, colour)
    @string = string
    @size_mm = size_mm
    @colour = colour
  end
end

class BritishTextObjectAdapter < TextObject
  def initialize(bto)
    @bto = bto
  end

  def text
    @bto.string
  end

  def size_inches
    @bto.size_mm / 25.4
  end

  def color
    @bto.colour
  end
end

adaptee = BritishTextObject.new('wanker', 100, 'bloody hell')
adapter = BritishTextObjectAdapter.new(adaptee)
renderer = Renderer.render(adapter)
p renderer