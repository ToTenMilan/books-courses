require 'minitest/autorun'
require 'benchmark'

N = 1_000_000_000
class BenchmarkTest < Minitest::Test
  #*****************************************************************************
  # Dodawanie
  #*****************************************************************************
  def test_addition_integer
    i = 1
    tmp = 0
    time = Benchmark.realtime do
      N.times do
        tmp = i + 2
      end
    end    
    puts 'test_addition_integer=' + time.to_s
  end # test_addition_integer

  def test_addition_float
    i = 1.0
    tmp = 0.0
    time = Benchmark.realtime do
      N.times do
        tmp = i + 2.0
      end
    end    
    puts 'test_addition_float=' + time.to_s
  end # test_addition_float

  def test_addition_float_fraction
    i = 1.0
    tmp = 0.0
    time = Benchmark.realtime do
      N.times do
        tmp = i + 2.1
      end
    end    
    puts 'test_addition_float_fraction=' + time.to_s
  end # test_addition_float_fraction

  #*****************************************************************************
  # Odejmowanie
  #*****************************************************************************
  def test_subtraction_integer
    i = 1
    tmp = 0
    time = Benchmark.realtime do
      N.times do
        tmp = i - 1
      end
    end    
    puts 'test_subtraction_integer=' + time.to_s
  end # test_subtraction_integer

  def test_subtraction_float
    i = 1.0
    tmp = 0.0
    time = Benchmark.realtime do
      N.times do
        tmp = i - 1.0
      end
    end    
    puts 'test_subtraction_float=' + time.to_s
  end # test_subtraction_float

  def test_subtraction_float_fraction
    i = 1.0
    tmp = 0.0
    time = Benchmark.realtime do
      N.times do
        tmp = i - 0.1
      end
    end    
    puts 'test_subtraction_float_fraction=' + time.to_s
  end # test_subtraction_float_fraction
  #*****************************************************************************
  # Mnożenie
  #*****************************************************************************
  def test_mul_integer
    i = 1
    tmp = 0
    time = Benchmark.realtime do
      N.times do
        tmp = i * 3
      end
    end
    puts 'test_mul_integer=' + time.to_s
  end # test_mul_integer

  def test_mul_float
    i = 1.0
    tmp = 0.0
    time = Benchmark.realtime do
      N.times do
        tmp = i * 3.0
      end
    end
    puts 'test_mul_float=' + time.to_s
  end # test_mul_float

  def test_mul_float_fraction
    i = 1.0
    tmp = 0.0
    time = Benchmark.realtime do
      N.times do
        tmp = i * 3.1
      end
    end
    puts 'test_mul_float_fraction=' + time.to_s
  end # test_mul_float_fraction 
end # BenchmarkTest
