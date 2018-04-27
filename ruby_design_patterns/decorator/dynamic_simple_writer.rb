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

# class WriterDecorator
#   extend Forwardable

#   ###### using forwardable
#   # def_delegators :@real_writer, :write_line, :rewind, :pos, :close

#   # def initialize(real_writer)
#   #   @real_writer = real_writer
#   # end

#   ##### classic decorator component
#   def initialize(real_writer)
#     @real_writer = real_writer
#   end

#   def write_line(line)
#     @real_writer.write_line(line)
#   end

#   def pos
#     @real_writer.pos
#   end

#   def rewind
#     @real_writer.rewind
#   end

#   def close
#     @real_writer.close
#   end
# end

module TimeStampingWriter
  def write_line(line)
    super("#{Time.new}: #{line}")
  end
end

module NumberingWriter
  attr_reader :line_number

  def write_line(line)
    @line_number = 1 unless @line_number
    super("#{@line_number}: #{line}")
    @line_number += 1
  end
end

# class Writer
#   def write(line)
#     @f.write(line)
#   end
# end

w = SimpleWriter.new('out')
w.extend(NumberingWriter) # cover(decorate) SimpleWroter method
w.extend(TimeStampingWriter) # cover(decorate) SimpleWroter method
### last module added will be the first one called (top element of decoeration)

w.write_line('yolo')