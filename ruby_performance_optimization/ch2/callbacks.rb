#---
# Excerpted from "Ruby Performance Optimization",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/adrpo for more book information.
#---

# Memory leak version
# module Logger
#   extend self
#   attr_accessor :output, :log_actions

#   def log(&event)
#     self.log_actions ||= []
#     self.log_actions << event
#   end

#   def play
#     output = []
#     log_actions.each { |e| e.call(output) }
#     puts output.join("\n")
#   end
# end

# class Thing
#   def initialize(id)
#     Logger.log { |output| output << "created thing #{id}" }
#   end
# end

# def do_something
#   1000.times { |i| Thing.new(i) }
# end

# do_something
# GC.start
# Logger.play
# puts ObjectSpace.each_object(Thing).count
# GC.start
# puts ObjectSpace.each_object(Thing).count ##### still 1000 (memory leak)


## No memory leak version
module Logger
  extend self
  attr_accessor :output

  def log(&event)
    self.output ||= []
    event.call(output)
  end

  def play
    puts output.join("\n")
  end
end

class Thing
  def initialize(id)
    Logger.log { |output| output << "created thing #{id}" }
  end
end

def do_something
  1000.times { |i| Thing.new(i) }
end

do_something
GC.start
Logger.play
puts ObjectSpace.each_object(Thing).count

# So be careful every time you create a block or Proc callback.
# Remember, if you store it somewhere, you will also keep references to its execution context.
# That not only hurts the performance, but also might even leak memory.
