require 'minitest/autorun'
require_relative 'fizz_buzz'
require_relative 'virtual_clock'

class TestFizzBuzz < Minitest::Test
  def test_write_fizz_buzz_for_multiples_of_3
    # fb = FizzBuzz.new
    # result = fb.transform(3)
    # assert_equal('Fizz', result)
    # assert_output('Fizz') { fb.output(3) }

    mock = MiniTest::Mock.new
    mock.expect(:write, nil, ['Fizz'])

    fb = FizzBuzz.new(mock)
    fb.output(3)

    mock.verify
  end

  def test_generate_fizz_buzz_for_multiples_of_5
    fb = FizzBuzz.new
    result = fb.transform(5)
    assert_equal('Buzz', result)
  end

  def test_generate_fizz_buzz_for_multiples_of_15
    fb = FizzBuzz.new
    result = fb.transform(15)
    assert_equal('FizzBuzz', result)
  end

  def test_generate_number_is_not_multiple
    fb = FizzBuzz.new
    result = fb.transform(1)
    assert_equal(1, result)
  end

  def test_generate_random_number_between_1_and_100_inclusive
    fb = FizzBuzz.new
    result = fb.random
    assert_includes((1..100).to_a, result)
  end

  def test_generate_fizz_morning_for_mornings
    clock = VirtualClock.new
    clock.hour = 10
    fb = FizzBuzz.new nil, clock
    result = fb.transform(3)

    assert_equal 'Fizz Morning', result
  end

  def test_generate_fizz_morning_for_not_morning
    clock = VirtualClock.new
    clock.hour = 14
    fb = FizzBuzz.new(nil, clock)
    result = fb.transform(3)

    assert_equal('Fizz', result)
  end
end
