# require_relative 'fizz_buzz_engine'
require_relative 'fixnum_extensions'

class FizzBuzz
  using FixnumExtensions
  def initialize(output = $stdout)
    @output = output
  end

  def transform(n)
    sequence[n-1]
  end

  def output(n)
    result = transform(n)
    @output.write result
  end

  def random
    numbers.sample
  end

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
