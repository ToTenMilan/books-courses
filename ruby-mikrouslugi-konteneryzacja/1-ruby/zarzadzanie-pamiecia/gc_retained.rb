GC.start
before = GC.stat(:total_freed_objects)

RETAINED = [] # constants are not garbage collected (also global vars, modules and classes)
100_000.times do
  RETAINED << "a string"
end

GC.start
after = GC.stat(:total_freed_objects)
puts "Objects Freed: #{after - before}"

# Objects Freed: 39