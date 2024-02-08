require 'minitest/autorun'
require 'minitest/benchmark'

class IterativeFactorial
  def self.calculate(n)
    result = 1
    2.upto(n) {|x| result *= x }
    result
  end
end

class RecursiveFactorial
  def self.calculate(n)
    if n < 2
      1
    else
      n * calculate(n-1)
    end
  end
end

class TestFactorial < Minitest::Benchmark
  def bench_iterative_factorial
    assert_performance_linear 0.99 do |n|
      n.times { IterativeFactorial.calculate(20) }
    end
  end

  def bench_recursive_factorial
    assert_performance_linear 0.99 do |n|
      n.times { RecursiveFactorial.calculate(20) }
    end
  end
end
