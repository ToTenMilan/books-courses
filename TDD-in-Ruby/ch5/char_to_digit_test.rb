require 'minitest/autorun'

class CharacterConverter
  def initialize(n)
    @n = n
    @numbers = n.bytes
  end

  def to_i
    first_element = @numbers.shift
    first_number = ascii_value(first_element)

    previous_number = first_number
    until complete?
      next_element = @numbers.shift
      next_number = ascii_value(next_element)
      previous_number = previous_number * 10 + next_number
    end
    previous_number
  end

  private

  def ascii_value(n)
    n.ord - '0'.ord
  end

  def complete?
    !(@numbers.size > 0)
  end
end

describe CharacterConverter do
  it "should convert '0' to 0" do
    cc = CharacterConverter.new('0')
    result = cc.to_i
    assert_equal 0, result
  end
  it "should convert '1' to 1" do
    cc = CharacterConverter.new('1')
    result = cc.to_i
    assert_equal 1, result
  end
  it "should convert '10' to 10" do
    cc = CharacterConverter.new('10')
    result = cc.to_i
    assert_equal 10, result
  end

  #it "should convert '100' to 100"

  #it "should convert '1000' to 1000"

  it "should convert '1984' to 1984" do

    cc = CharacterConverter.new('1984')
    result = cc.to_i
    assert_equal 1984, result
  end
end
