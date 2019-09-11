module EnthusiasticGreetings
  def greet # will be used when prepending
    "Hey, #{super}!"
  end
end

class MyClass
  # by including module gets higher than class so MyClass#greet overrides EnthusiasticGreetings#greet
  # include EnthusiasticGreetings # dont works

  # by prepending module gets lower than class, so EnthusiasticGreetings#greet overrides MyClass#greet
  prepend EnthusiasticGreetings # works
  def greet # wont be used because of `prepend`
    'hello'
  end
end

# with `include`
# p MyClass.ancestors # => [MyClass, EnthusiasticGreetings, Object, Kernel, BasicObject]
# p MyClass.new.greet # => 'hello'

# with `prepend`
p MyClass.ancestors # => [EnthusiasticGreetings, MyClass, Object, Kernel, BasicObject]
p MyClass.new.greet # => 'Hey, hello!'