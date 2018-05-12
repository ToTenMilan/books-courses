class HTMLReader
end

class HTMLWriter
end

class PDFReader
end

class PDFWriter
end

class IOFactory
  def initialize(format)
    puts self.class
    @reader_class = self.class.const_get("#{format}Reader")
    @writer_class = self.class.const_get("#{format}Writer")
  end

  def new_reader
    @reader_class.new
  end

  def new_writer
    @writer_class.new
  end
end

html_factory = IOFactory.new('HTML')
html_reader = html_factory.new_reader
puts html_reader.class

pdf_factory = IOFactory.new('PDF')
pdf_writer = pdf_factory.new_writer
puts pdf_writer.class

IOFactory.class.const_get("YoloReader") # => error