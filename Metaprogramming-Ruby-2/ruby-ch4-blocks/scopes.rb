definded_in_main = 1

class Foo
  defined_in_foo = 2
  p "1: #{local_variables}"

  def bar
    defined_in_foo_bar = 3
    p "2: #{local_variables}"
  end

  p "3: #{local_variables}"
end

foo = Foo.new
foo.bar
foo.bar
p "4: #{local_variables}"

# "1: [:defined_in_foo]"
# "3: [:defined_in_foo]"
# "2: [:defined_in_foo_bar]"
# "2: [:defined_in_foo_bar]"
# "4: [:definded_in_main, :foo]"
