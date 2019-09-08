# this is how method should work
class Person
  include CheckedAttributes

  attr_checked :age do |v|
    v >= 18
  end
end

pr = Person.new
pr.age = 39 # => OK
pr.age = 12 # => Exception