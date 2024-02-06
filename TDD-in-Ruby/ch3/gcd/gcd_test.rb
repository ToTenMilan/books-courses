# while non-zero remainder do
#   continue search for gcd
# end

require 'minitest/autorun'

class GreatestCommonDivisor
  def initialize(a, b)
    @a = a
    @b = b
    initialize_numbers
  end

  def initialize_numbers
    if @a > @b
      @bigger_number = @a
      @smaller_number = @b
    else
      @bigger_number = @b
      @smaller_number = @a
    end
  end

  def calculate
    remainder = 1
    dividend = @bigger_number
    divisor = @smaller_number
    until remainder == 0
      remainder = dividend % divisor
      dividend = divisor
      divisor = remainder
    end
    dividend
  end
end

describe GreatestCommonDivisor do
  it 'should return 4 for 8 and 12' do
    gcd = GreatestCommonDivisor.new(8, 12)
    result = gcd.calculate
    assert_equal 4, result
  end

  it 'should return 6 for 54 and 24' do
    gcd = GreatestCommonDivisor.new(24,54)
    result = gcd.calculate
    assert_equal 6, result
  end

  it 'should return 6 for 12 and 30' do
    gcd = GreatestCommonDivisor.new(12, 30)
    result = gcd.calculate
    assert_equal 6, result
  end
end
