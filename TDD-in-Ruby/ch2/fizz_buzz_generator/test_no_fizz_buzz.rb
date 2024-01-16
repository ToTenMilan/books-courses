require 'minitest/autorun'
require_relative 'no_fizz_buzz'

class TestNoFizzBuzz < Minitest::Test
  def test_no_fizz_buzz
    fb = NoFizzBuzz.new
    result = fb.value(1, ->{})
    assert_equal(1, result, 'Failure in the NoFizzBuzz value method')
  end
end
