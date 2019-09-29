# this is the funny one

fork do
  puts "Zombie: *comes out of grave*"
  puts "Zombie: rahhh...kill me with: $ kill #{$$}"
  loop do
    puts "Zombie (#{$$}): brains..."
    sleep 1
  end # loop
end # fork
puts "Main (#{$$}): finished"