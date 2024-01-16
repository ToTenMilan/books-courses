class Stack
  def initialize
    @elements = []
  end

  def push(element)
    @elements << element
  end

  def size
    @elements.size
  end

  def pop
    @elements.pop
  end

  def top
    @elements.last
  end
end
