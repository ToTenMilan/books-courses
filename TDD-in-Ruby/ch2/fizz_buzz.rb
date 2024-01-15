# require_relative 'fizz_buzz_engine'
require_relative 'fixnum_extensions'

class FizzBuzz
  using FixnumExtensions
  def initialize(output = $stdout, clock)
    @output = output
    @clock = clock
  end

  def transform(n)
    result = sequence[n-1]
    if @clock && @clock.morning?
      result = "#{result} Morning"
    end
    result
  end

  def output(n)
    result = transform(n)
    @output.write(result)
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
