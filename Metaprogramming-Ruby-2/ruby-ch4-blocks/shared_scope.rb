def define_methods
  shared = 0

  # use 'send' to access private class method
  Kernel.send :define_method, :counter do
    shared
  end

  # use 'send' to access private class method
  Kernel.send :define_method, :inc do |x|
    shared += x
  end
end

define_methods

# two kernel methods are sharing the same variable, shared only between them
puts counter # => 0
inc(4)
puts counter # => 4