class Foo
  def initialize
    @v = 1
  end
end

foo = Foo.new

foo.instance_eval do
  p self # => #<Foo:0x0a88 @v=1>
  p @v  # => 1
end

v = 2

foo.instance_eval { @v = v }
foo.instance_eval { p @v } # => 2