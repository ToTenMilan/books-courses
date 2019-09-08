array = %w[a b c]
x = 'd'
array.instance_eval "self[1] = x"

p array # => ["a", "d", "c"]