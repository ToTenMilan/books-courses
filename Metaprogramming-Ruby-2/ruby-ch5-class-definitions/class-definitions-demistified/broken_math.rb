class Integer
  alias_method :plus, :+
  def +(arg)
    self.plus(arg).plus(1)
  end
end

p 1 + 1