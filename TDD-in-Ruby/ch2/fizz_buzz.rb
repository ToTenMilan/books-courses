# require_relative 'fizz_buzz_engine'
require_relative 'fixnum_extensions'

class FizzBuzz
  # def sequence
  #   numbers.collect do |n|
  #     fbe = FizzBuzzEngine.new(n)
  #     fbe.value
  #   end
  # end

  using FixnumExtensions


  def transform(n)
    sequence[n-1]
  end

  # def transform(number)
  #   pairs = {}
  #   (1..100).each do |n|
  #     pairs[n] = n
  #   end
  #   result = {}
  #   pairs.keys.each do |key|
  #     result[key] = key.fizz_buzz
  #   end
  #   result[number]
  # end

  private

  def sequence
    numbers.collect do |n|
      n.fizz_buzz
    end
  end

  def numbers
    (1..100).to_a
  end
end
