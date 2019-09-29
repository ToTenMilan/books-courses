require 'minitest/autorun'
require 'benchmark'

N = 1_000_000_000

class BenchmarkDivisionTest < Minitest::Test
  def test_div_integer
    i = 10
    tmp = 0
    time = Benchmark.realtime do
      N.times do
        tmp = i / 5
      end
    end
    puts 'test_div_integer=' + time.to_s
  end # test_div_integer

  def test_div_float
    i = 10.0
    tmp = 0.0
    time = Benchmark.realtime do
      N.times do
        tmp = i / 5.0
      end
    end
    puts 'test_div_float=' + time.to_s
  end # test_div_float

  def test_div_float_fraction
    i = 10.0
    tmp = 0.0
    time = Benchmark.realtime do
      N.times do
        tmp = i / 4.9
      end
    end
    puts 'test_div_float_fraction=' + time.to_s
  end # test_div_float_fraction 
end # BenchmarkDivisionTest