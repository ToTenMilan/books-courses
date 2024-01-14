require 'minitest/autorun'
require_relative 'fizz_buzz'

class TestFizzBuzz < Minitest::Test
  def test_generate_numbers_from_1_to_100
    fb = FizzBuzz.new
    result = fb.numbers
    assert_equal((1..100).to_a, result)
  end

  def test_generate_fizz_buzz_for_multiples_of_3
    fb = FizzBuzz.new
    result = fb.sequence
    assert_equal('Fizz', result[2])
  end

  def test_generate_fizz_buzz_for_multiples_of_5
    fb = FizzBuzz.new
    result = fb.sequence
    assert_equal('Buzz', result[4])
  end

  def test_generate_fizz_buzz_for_multiples_of_3_and_5
    fb = FizzBuzz.new
    result = fb.sequence
    assert_equal('FizzBuzz', result[14])
  end
end
