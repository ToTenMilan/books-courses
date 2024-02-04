require 'minitest/autorun'
require 'prime'
require_relative 'erastostenes_test'

# rozkladanie na czynniki pierwsze
# 60 / 2 = 30 => get prime 2
# 30 / 2 = 15 => get prime 2
# 15 / 2 = *
# 15 / 3 = 5 => get prime 3
# 5 / 3 = *
# 5 / 4 = *
# 5 / 5 = 1 => get prime 5
# 1

# 60 = 2 x 2 x 3 x 5

class PrimeFactor
  def initialize(number)
    @number = number
  end

  def calculate
    result = []
    current_prime = 2
    until Prime.prime?(@number)
      if (@number % current_prime) == 0
        result << current_prime
        @number = @number / current_prime
      else
        current_prime = Erastostenes.next(current_prime)
      end
    end
    result << @number
    result
  end
end

describe PrimeFactor do
  it 'returns 2 for input of 2' do
    prime_factorial = PrimeFactor.new(2)
    result = prime_factorial.calculate
    assert_equal([2], result)
  end

  it 'returns 3 for imput out of 3' do
    prime_factoorial = PrimeFactor.new(3)
    result = prime_factoorial.calculate
    assert_equal([3], result)
  end

  it 'should return [2,2] for input of 4' do
    prime_factorial = PrimeFactor.new(4)
    result = prime_factorial.calculate
    assert_equal([2,2], result)
  end

  it 'should return [3,7,7] for input of 147' do
    prime_factorial = PrimeFactor.new(147)
    result = prime_factorial.calculate
    assert_equal [3,7,7], result
  end

  it 'should return [2,3] for input of 6' do
    prime_factorial = PrimeFactor.new(6)
    result = prime_factorial.calculate
    assert_equal [2,3], result
  end

  it 'should return [2,2,2] for input of 8' do
    prime_factorial = PrimeFactor.new(8)
    result = prime_factorial.calculate
    assert_equal [2,2,2], result
  end

  it 'should return [2,7] for input of 14' do
    prime_factorial = PrimeFactor.new(14)
    result = prime_factorial.calculate
    assert_equal [2,7], result
  end

  it 'should handle any number' do
    prime_factorial = PrimeFactor.new(168)
    result = prime_factorial.calculate
    assert_equal [2, 2, 2, 3, 7], result
  end
end
