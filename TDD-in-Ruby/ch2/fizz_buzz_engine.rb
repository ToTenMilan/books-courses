class FizzBuzzEngine
  # LOOKUP = {15 => 'FizzBuzz', 3 => 'Fizz', 5 => 'Buzz'}

  def initialize(number)
    @number = number
  end


  def value
    # LOOKUP.keys.each do |key|
    #   return LOOKUP[key] if multiple_of(key)
    # end

    return 'FizzBuzz' if multiple_of(15)
    return 'Fizz' if multiple_of(3)
    return 'Buzz' if multiple_of(5)
    @number
  end

  private

  def multiple_of(divisor)
    @number.modulo(divisor).zero?
  end
end
