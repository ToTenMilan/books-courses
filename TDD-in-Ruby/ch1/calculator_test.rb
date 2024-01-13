require 'minitest/autorun'
require_relative 'calculator'

class TestCalculator < Minitest::Test
  def test_addition
    calculator = Calculator.new
    result = calculator.add(1, 2)

    assert_equal(3, result)
  end

  def test_subtraction
    calculator = Calculator.new
    result = calculator.subtract(3, 2)

    assert_equal(1, result)
  end

  def test_multiplication
    calculator = Calculator.new
    result = calculator.multiply(2, 2)

    assert_equal(4, result)
  end

  def test_division
    calculator = Calculator.new
    result = calculator.divide(4, 2)

    assert_equal(2, result)
  end
end
