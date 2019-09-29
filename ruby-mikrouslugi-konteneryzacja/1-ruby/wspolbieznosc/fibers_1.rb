# works like Python `yield` (generator)

class Counter
  def initialize(init)
    @fiber = Fiber.new do
      n = init
      loop do
        Fiber.yield n
        n += 1
      end # loop
    end # Fiber.new
  end # initialize

  def next
    @fiber.resume
  end # next
end # Counter

counter = Counter.new(0)
puts counter.next
# => 0
puts counter.next
# => 1
puts counter.next
# => 2