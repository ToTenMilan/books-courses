require 'minitest/autorun'
require_relative 'stack'

class TestStack < Minitest::Test
  def test_should_push_a_given_item
    stack = Stack.new
    stack.push(2)
    assert_equal 1, stack.size
  end

  def test_should_push_a_given_item
    stack = Stack.new
    stack.push(2)
    result = stack.pop
    assert_equal(2, result)
  end
end
