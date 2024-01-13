require 'minitest/autorun'

class Multiplier
  def multiply(numbers)
    numbers.inject do |result, number|
      result *= number
    end
  end
end

describe Multiplier do
  it 'multiplies 1,2,3 and returns 6' do
    multiplier = Multiplier.new
    result = multiplier.multiply([1,2,3])

    assert_equal(6, result)
  end

  it 'multiplies 2,3,4 and returns 24' do
    multiplier = Multiplier.new
    result = multiplier.multiply([2,3,4])

    assert_equal(24, result)
  end

  it 'multiplies 0,0,0 and returns 0' do
    multiplier = Multiplier.new
    result = multiplier.multiply([0,0,0])

    assert_equal(0, result)
  end

  it 'multiplies 1,1,1 and returns 1' do
    multiplier = Multiplier.new
    result = multiplier.multiply([1,1,1])

    assert_equal(1, result)
  end

  it 'multiplies -10, 10 and returns -100' do
    multiplier = Multiplier.new
    result = multiplier.multiply([-10,10])

    assert_equal(-100, result)
  end

  it 'multiplies -1,-1-1 and returns 0' do
    multiplier = Multiplier.new
    result = multiplier.multiply([-1,-1,-1])

    assert_equal(-1, result)
  end
end
