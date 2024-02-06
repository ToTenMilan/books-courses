require 'minitest/autorun'

class Calculator
  def add(addend, augend)
    # "fake it till you kmake it" chapter
    # addend+augend

    # triangulation chapter
    addend + augend
  end
end

class TestCaculator < Minitest::Test
  # "fake it till you kmake it" chapter
  # def test_addition
  #   calculator = Calculator.new
  #   result = calculator.add(1, 2)
  #   assert_equal 3, result
  # end

  # triangulation chapter
  def test_addition
    calculator = Calculator.new
    result = calculator.add(1, 2)
    assert_equal 3, result
  end
end
