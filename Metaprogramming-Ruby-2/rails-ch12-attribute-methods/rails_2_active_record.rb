# gems/activerecord-2.3.2/lib/active_record/attribute_methods.rb
​module​ ActiveRecord
  ​module​ AttributeMethods

    ​def​ method_missing(method_id, *args, &block)
      method_name = method_id.to_s
      ​if​ self.class.private_method_defined?(method_name)
        raise NoMethodError.new(​"Attempt to call private method"​, method_name, args)
      ​end​
      ​# If we haven't generated any methods yet, generate them, then​
      ​# see if we've created the method we're looking for.​
      ​if​ !self.class.generated_methods?
        self.class.define_attribute_methods
        ​if​ self.class.generated_methods.include?(method_name)
          ​return​ self.send(method_id, *args, &block)
        ​end​
      ​end​
      ​# ...​
      # second part of method_missing handles cases where attributes are not backed by database table
      if​ self.class.primary_key.to_s == method_name
        id
      ​elsif​ md = self.class.match_attribute_method?(method_name)
        attribute_name, method_type = md.pre_match, md.to_s
        ​if​ @attributes.include?(attribute_name)
          __send__(​"attribute​#{method_type}​"​, attribute_name, *args, &block)
        ​else​
          ​super​
        ​end​
      ​elsif​ @attributes.include?(method_name)
        read_attribute(method_name)
      ​else​
        ​super​
      ​end​
    ​end​
    
    private
      ​# Handle *? for method_missing.​
      ​def​ attribute?(attribute_name)
        query_attribute(attribute_name)
      ​end​
      ​# Handle *= for method_missing.​
      ​def​ attribute=(attribute_name, value)
        write_attribute(attribute_name, value)
      ​end
    ​end​

    ​def​ read_attribute(attr_name)         ​# ...​
    ​def​ write_attribute(attr_name, value) ​# ...​
    ​def​ query_attribute(attr_name)        ​# ...

    # Generates all the attribute related methods for columns in the database​
    ​# accessors, mutators and query methods.​
    ​def​ define_attribute_methods
      ​return​ ​if​ generated_methods?
      columns_hash.each ​do​ |name, column|

        ​unless​ instance_method_already_implemented?(name)
          ​if​ self.serialized_attributes[name]
            define_read_method_for_serialized_attribute(name)
          ​elsif​ create_time_zone_conversion_attribute?(name, column)
            define_read_method_for_time_zone_conversion(name)
          ​else​
            define_read_method(name.to_sym, name, column)
          ​end​
        ​end​

        ​unless​ instance_method_already_implemented?(​"​#{name}​="​)
          ​if​ create_time_zone_conversion_attribute?(name, column)
            define_write_method_for_time_zone_conversion(name)
          ​else​
            define_write_method(name.to_sym)
          ​end​
        ​end​

        ​unless​ instance_method_already_implemented?(​"​#{name}​?"​)
          define_question_method(name)
        ​end​
      ​end​
    ​end

    # gems/activerecord-2.3.2/lib/active_record/attribute_methods.rb
    ​def​ define_write_method(attr_name)
      evaluate_attribute_method attr_name,
         ​"def ​#{attr_name}​=(new_value);write_attribute('​#{attr_name}​', new_value);end"​,
         ​"​#{attr_name}​="​
    ​end​

    ​def​ evaluate_attribute_method(attr_name, method_definition, method_name=attr_name)
      ​unless​ method_name.to_s == primary_key.to_s
        generated_methods << method_name
      ​end​
      ​begin​
        class_eval(method_definition, __FILE__, __LINE__)
      ​rescue​ SyntaxError => err
        generated_methods.delete(attr_name)
        ​if​ logger
          logger.warn ​"Exception occurred during reader method compilation."​
          logger.warn ​"Maybe ​#{attr_name}​ is not a valid Ruby identifier?"​
          logger.warn err.message
        ​end​
      ​end​
    ​end