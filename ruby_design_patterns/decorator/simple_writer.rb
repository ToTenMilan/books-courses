require 'forwardable'

class SimpleWriter
  def initialize(path)
    @file = File.open(path, 'w')
  end

  def write_line(line)
    @file.print(line)
    @file.print("\n")
  end

  def pos
    @file.pos
  end

  def rewind
    @file.rewind
  end

  def close
    @file.close
  end
end

class WriterDecorator
  extend Forwardable

  def_delegators :@real_writer, :write_line, :rewind, :pos, :close

  def initialize(real_writer)
    @real_writer = real_writer
  end

  ##### classic decorator component
  # def initialize(real_writer)
  #   @real_writer = real_writer
  # end

  # def write_line(line)
  #   @real_writer.write_line(line)
  # end

  # def pos
  #   @real_writer.pos
  # end

  # def rewind
  #   @real_writer.rewind
  # end

  # def close
  #   @real_writer.close
  # end
end

class NumberingWriter < WriterDecorator
  def initialize(real_writer)
    super(real_writer)
    @line_number = 1
  end

  def write_line(line)
    @real_writer.write_line("#{@line_number}: #{line}")
    @line_number += 1
  end
end

class CheckSummingWriter < WriterDecorator
  attr_reader :check_sum

  def initialize(real_writer)
    @real_writer = real_writer
    @check_sum = 0
  end

  def write_line(line)
    line.each_byte { |byte| @check_sum = (@check_sum + byte) % 256 }
    @check_sum += "\n".each_byte.first % 256
    @real_writer.write_line(line)
  end
end

class TimeStampingWriter < WriterDecorator
  def write_line(line)
    @real_writer.write_line("#{Time.new}: #{line}")
  end
end

writer = TimeStampingWriter.new CheckSummingWriter.new NumberingWriter.new SimpleWriter.new('final.txt')
writer.write_line('Yolo')
writer.write_line('whatsup')

####### dynamic alternatives to decorator pattern, good just for small scale problems
# w = SimpleWriter.new('out')

# class << w
#   alias old_write_line write_line

#   def write_line(line)
#     old_write_line("#{Time.new}: #{line}")
#   end
# end


