
ret = RubyVM::InstructionSequence.compile 'puts "Hello, world!"'
puts ret.inspect
puts ret.disasm