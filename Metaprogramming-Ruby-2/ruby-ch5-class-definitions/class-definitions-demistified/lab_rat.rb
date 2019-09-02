# how method lookup works, including "Singleton Classes"

class C
  def a_method
    'C#a_method()'
  end
end

class D < C; end

class D
  def a_singleton_method
    'I will be returned if obj.wont have a singleton method with the same name'
  end
end

obj = D.new
p obj.a_method

# class << obj
#   def a_singleton_method
#     'obj#a_singleton_method()'
#   end
# end

p obj.singleton_class
p obj.singleton_class.superclass

p obj.a_singleton_method

# Conclusion
# method lookup

# Object                          # then check if the instance method is in Object class 
# ^ C                             # then check if the instance method is in C class 
# ^ D                             # then check if the instance method is in D class 
# obj.a_singleton_method < obj    # first check if 'obj' has 'a_singleton_method' defined on itself

class C
  class << self
    def a_class_method
      'C.a_class_method()'
    end
  end
end

p obj.singleton_class.singleton_class