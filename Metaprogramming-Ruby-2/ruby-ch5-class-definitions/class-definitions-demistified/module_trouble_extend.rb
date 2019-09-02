module MyModule
  def my_method
    'helo'
  end
end

obj = Object.new
obj.extend MyModule # same as opening singleton class by 'class << obj'
p obj.my_method

class MyClass
  extend MyModule
end

p MyClass.my_method