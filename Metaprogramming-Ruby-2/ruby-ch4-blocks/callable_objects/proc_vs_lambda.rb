def double(callable_object)
  callable_object.call * 2
end

l = lambda { return 10 }
p double(l)

def double_double
  pr = Proc.new { return 10 } # here 'return' will return from scope that calls 'pr'
  result = pr.call
  return result * 2 # unreachable code
end

p double_double

# buggy
# def buggy_double(callable_object)
#   callable_object.call * 2
# end

# prc2 = Proc.new { p 'in proc without return'; 10 }
# p buggy_double(prc2) # => 20

# prc = Proc.new { p 'in proc with return'; return 10 } # returning to main
# p buggy_double(prc) # => no output

# p 'I am unreachable'
