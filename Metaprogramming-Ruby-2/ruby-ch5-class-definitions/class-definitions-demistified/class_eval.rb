def add_method_to(a_class)
  a_class.class_eval do # open class passed in argument and define instance method in it
    def m
      'Yolo'
    end
  end
end

add_method_to String
p 'yolo'.m