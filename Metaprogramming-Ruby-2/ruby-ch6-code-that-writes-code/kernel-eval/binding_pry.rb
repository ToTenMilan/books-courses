class Foo
  def bar
    a = 1
    b = 2
    require 'pry'; binding.pry # opening 'pry' interpreter, where variable scould be inspect
    c = 3
    d = a + b
    puts d
  end
end

Foo.new.bar