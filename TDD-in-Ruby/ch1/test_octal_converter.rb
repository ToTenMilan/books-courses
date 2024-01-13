require 'minitest/autorun'
require_relative 'octal_converter'

describe OctalConverter do
  it 'should return 1 for 1' do
    converter = OctalConverter.new(1)
    result = converter.convert
    assert_equal [1], result
  end

  it 'should return 2 for 2' do
    converter = OctalConverter.new(2)
    result = converter.convert
    assert_equal [2], result
  end

  it 'should return 10 for 8' do
    converter = OctalConverter.new(8)
    result = converter.convert
    assert_equal [1, 0], result
  end

  it 'should return 137 in octal for 95 decimal' do
    converter = OctalConverter.new(95)
    result = converter.convert
    assert_equal [1,3,7], result
  end

  it 'should return 4000 for 2048' do
    converter = OctalConverter.new(2048)
    result = converter.convert
    assert_equal [4,0,0,0], result
  end
end
