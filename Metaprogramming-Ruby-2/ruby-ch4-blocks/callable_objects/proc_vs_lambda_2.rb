pr = Proc.new { |a,b| [a,b] }
p pr.arity # => 2
p pr.call(1,2,3) # => [1, 2]
p pr.call(1) # => [1, nil]

la = lambda { |a,b| [a, b] }
p la.arity # => 2
# p la.call(1,2,3) # =>  wrong number of arguments (given 3, expected 2) (ArgumentError)
p la.call(1) # =>  wrong number of arguments (given 1, expected 2) (ArgumentError)