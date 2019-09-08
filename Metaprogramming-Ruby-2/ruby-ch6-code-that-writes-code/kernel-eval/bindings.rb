class Foo
  def bar
    @x = 1
    binding
  end
end

b = Foo.new.bar
p b

p eval "@x", b