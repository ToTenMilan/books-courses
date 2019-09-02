module MyModule
  def my_method
    'hello from MyModule'
  end
end

class MyClass
  class << self
    include MyModule
  end
end

p MyClass.my_method

