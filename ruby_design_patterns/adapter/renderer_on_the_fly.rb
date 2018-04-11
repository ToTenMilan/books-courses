require_relative 'renderer' # require BritishTextObject

class BritishTextObject # modify required class on the fly
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