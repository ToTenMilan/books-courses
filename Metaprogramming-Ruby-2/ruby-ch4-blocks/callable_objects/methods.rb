class Dog
  def initialize(value)
    @legs = value
  end

  def legs
    @legs
  end
end

dog = Dog.new(4)
legs_num = dog.method :legs # save method 'legs' in 'legs_num' callable object
p legs_num.class # => Method
p legs_num.call # => 4