require 'minitest/autorun'

class Calculator
  def multiply(a, b)
    a * b
  end
end

class TestCalculator < Minitest::Test
  def test_multiplication
    calculator = Calculator.new
    result = calculator.multiply(3, 2)
    assert_equal 6, result
  end
end
