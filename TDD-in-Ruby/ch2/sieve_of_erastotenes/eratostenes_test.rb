require 'minitest/autorun'

class Erastotenes
  def initialize(limit)
    @limit = limit
    @list = (2..@limit).to_a
  end

  def number_list
    (2..@limit).to_a
  end

  def calculate
    list = number_list
    list.each do |x|
      unless x >= Math.sqrt(@limit)
        cross_out_multiples_of(x)
      end
    end
  end

  def cross_out_multiples_of_two
    cross_out_multitples_of(2)
  end

  def cross_out_multiples_of_three
    @list = cross_out_multiples_of_two
    list.reject do |x|
      unless x == 0
        x % 3 == 0
      end
    end
  end

  def cross_out_multiples_of_five
    list = cross_out_multiples_of_three
    list.reject do |x|
      unless x == 0
        x % 5 == 0
      end
    end
  end

  private

  def cross_out_multitples_of(number)
    @list.reject do |x|
      unless x == 0
        x % number == 0
      end
    end
  end
end

describe Erastotenes do
  it 'makes a list of all integers <= 30 and greator than 1' do
    e = Erastostenes.new(30)
    result = e.number_list
    expected = [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30]
    assert_equal expected, result
  end

  # it 'crosses out out multiples of 2' do
  #   e = Erastotenes.new(30)
  #   result = e.cross_out_multiples_of_two
  #   expected = [2,3,5,7,9,11,13,15,17,19,21,23,25,27,29]
  #   assert_equal expected, result
  # end

  # it 'crosses out the multiples of 2 and 3' do
  #   e = Erastotenes.new(30)
  #   result = e.cross_out_multiples_of_three
  #   expected = [2,3,5,7,11,13,17,19,23,25,29]
  #   assert_equal expected, result
  # end

  # it 'crosses out multiples of 2, 3, and 5' do
  #   e = Erastostenes.new(30)
  #   result = e.cross_out_multiples_of_five
  #   expected = [2,3,5,7,11,13,17,19,23,29]
  #   assert_equal expected, result
  # end

  it 'should calculate the prime numbers for 30' do
    e = Erastotenes.new(30)
    result = e.calculate
    expected = [2,3,5,7,11,13,17,19,23,29]
    assert_equal expected, result
  end
end
