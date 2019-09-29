require 'objspace'

a = 'A'
b = 'B'

ObjectSpace.define_finalizer(a, proc { |id|
  puts "Finalizer one on: #{id}"
})

ObjectSpace.define_finalizer(b, proc { |id|
  puts "Finalizer two on: #{id}"
})