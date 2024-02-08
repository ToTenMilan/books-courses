require 'minitest/autorun'

class Factorial
  def self.calculate(n)
    result = 1
    2.upto(n) { |x| result *= x }
    result
  end
end

class TestFactorial < Minitest::Test
  def test_zero_factorial_is_one
    result = Factorial.calculate(0)
    assert_equal 1, result
  end

  def test_one_factorial_is_one
    result = Factorial.calculate(1)
    assert_equal 1, result
  end

  def test_two_factorial_is_two
    result = Factorial.calculate(2)
    assert_equal 2, result
  end

  def test_three_factorial_is_six
    result = Factorial.calculate(3)
    assert_equal 6, result
  end
end
