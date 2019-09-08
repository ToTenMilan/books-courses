class Foo
  def bar
    eval "self", TOPLEVEL_BINDING # access top-level scope from anywhere in program
  end
end

p Foo.new.bar # => main