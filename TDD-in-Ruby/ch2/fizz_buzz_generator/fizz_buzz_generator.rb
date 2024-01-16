require_relative 'fizz'
require_relative 'buzz'
require_relative 'fizz_buzz'
require_relative 'no_fizz_buzz'

class FizzBuzzGenerator
  def initialize(objects, list)
    @list = list
    @objects = objects
    @modulo_proc = ->(number, divisor) { number % divisor == 0 }
  end

  def generate
    result = []
    @list.each do |num|
      @objects.each do |l|
        v = l.value(num, @modulo_proc)
        unless v.nil?
          result << v
          break
        end
      end
    end
    result
  end
end
