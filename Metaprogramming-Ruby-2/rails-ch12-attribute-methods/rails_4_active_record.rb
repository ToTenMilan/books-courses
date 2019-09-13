module​ ActiveRecord
  ​module​ AttributeMethods
    ​module​ Read
      extend ActiveSupport::Concern

      ​module​ ClassMethods
        ​if​ Module.methods_transplantable?
          ​def​ define_method_attribute(name)
            method = ReaderMethodCache[name]
            generated_attribute_methods.module_eval { define_method name, method }
          ​end​
        ​else​
          ​def​ define_method_attribute(name)
            ​# ...​
          ​end​
        ​end

      # ...

      ReaderMethodCache = Class.new(AttributeMethodCache) {
        private
        ​# We want to generate the methods via module_eval rather than​
        ​# define_method, because define_method is slower on dispatch.​
        ​# Evaluating many similar methods may use more memory as the instruction​
        ​# sequences are duplicated and cached (in MRI).  define_method may​
        ​# be slower on dispatch, but if you're careful about the closure​
        ​# created, then define_method will consume much less memory.​
        ​#​
        ​# But sometimes the database might return columns with​
        ​# characters that are not allowed in normal method names (like​
        ​# 'my_column(omg)'. So to work around this we first define with​
        ​# the __temp__ identifier, and then use alias method to rename​
        ​# it to what we want.​
        ​#​
        ​# We are also defining a constant to hold the frozen string of​
        ​# the attribute name. Using a constant means that we do not have​
        ​# to allocate an object on each call to the attribute method.​
        ​# Making it frozen means that it doesn't get duped when used to​
        ​# key the @attributes_cache in read_attribute.​
        ​def​ method_body(method_name, const_name)
          ​<<-EOMETHOD​
​          def ​#{method_name}
​            name = ::ActiveRecord::AttributeMethods::AttrNames::ATTR_​#{const_name}
​            read_attribute(name) { |n| missing_attribute(n, caller) }​
​          end​
​          EOMETHOD​
        ​end​
      }.new
