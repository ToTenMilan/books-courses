module​ ActiveRecord
  ​module​ AttributeMethods

    AttrNames = Module.new {
      ​def​ self.set_name_cache(name, value)
        const_name = ​"ATTR_​#{name}​"​
        ​unless​ const_defined? const_name
          const_set const_name, value.dup.freeze
        ​end​
      ​end​
    }

    ​class​ AttributeMethodCache
      ​def​ initialize
        @module = Module.new
        @method_cache = ThreadSafe::Cache.new
      ​end​

      ​def​ [](name)
        @method_cache.compute_if_absent(name) ​do​
          safe_name = name.unpack(​'h*'​).first
          temp_method = ​"__temp__​#{safe_name}​"​
          ActiveRecord::AttributeMethods::AttrNames.set_name_cache safe_name, name
          @module.module_eval method_body(temp_method, safe_name),
                              __FILE__, __LINE__
          @module.instance_method temp_method
        ​end​
      ​end​
      
      private

      ​def​ method_body; raise NotImplementedError; ​end​
    ​end