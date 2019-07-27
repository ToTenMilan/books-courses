class C
  def initialize
    @x = 1
  end
end

class D
  def twisted_method
    @y = 2
    #  instance variables depend on self,
    # so when instance_eval switches self to the receiver,
    # all the instance variables in the caller fall out of scope.
    # The code inside the block interprets @y as an instance variable of C
    C.new.instance_eval { "@x: #{@x}, @y: #{@y}" }
  end
end

p D.new.twisted_method # => "@x: 1, @y: "


# class with @y variable in scope
class E
  def twisted_method
    @y = 2
    # instance_exec is accepting extra arguments,
    # that can be passed to block as block variables
    C.new.instance_exec(@y) { |y| "@x: #{@x}, @y: #{y}" } # => 
  end
end

p E.new.twisted_method # => "@x: 1, @y: 2"