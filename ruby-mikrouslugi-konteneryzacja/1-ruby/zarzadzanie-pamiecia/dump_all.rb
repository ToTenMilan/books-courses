require 'objspace'

# dump ruby objects from RAM
File.open('output.txt', 'w') do |f|
  ObjectSpace.dump_all(output: f)
end