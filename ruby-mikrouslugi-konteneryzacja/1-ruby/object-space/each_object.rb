print Numeric objects

a = 102.7
b = 95
c = 12345678987654321
count = ObjectSpace.each_object(String) { |x| p x }
puts count



