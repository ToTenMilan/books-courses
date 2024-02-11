require 'minitest/autorun'
require_relative 'fizz_buzz_generator'

class TestFizzBuzzGenerator < Minitest::Test
  def  test_fizz_buzz_sequence
    # Open-Close principle example
    objects = [FizzBuzz.new, Fizz.new, Buzz.new, NoFizzBuzz.new]
    g = FizzBuzzGenerator.new(objects, (1..20).to_a)

    result = g.generate
    expected = [1, 2, "Fizz", 4, "Buzz", "Fizz", 7, 8, "Fizz", "Buzz", 11, "Fizz", 13, 14, "FizzBuzz", 16, 17, "Fizz", 19, "Buzz"]

    # exercise
    # expected = [1, 2, 3, 4, "Buzz", 6, 'Fizz', 8, 9, "Buzz", 11, 12, 13, 'Fizz', "FizzBuzz", 16, 17, 18, 19, "Buzz"]

    assert_equal expected, result
  end
end
