class MyClass
  class << self # open MyClass's singleton class
    attr_accessor :c
  end
end

MyClass.c = 'attribute on a class (not on object, as usual)'
p MyClass.c