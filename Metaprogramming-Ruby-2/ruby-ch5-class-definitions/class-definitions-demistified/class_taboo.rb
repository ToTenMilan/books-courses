# class MyClass < Array
#   def my_method
#     'Hello'
#   end
# end

MyClass = Class.new(Array) do
  def my_method
    'hello'
  end
end

p MyClass.new.my_method
p MyClass.superclass
p MyClass.name