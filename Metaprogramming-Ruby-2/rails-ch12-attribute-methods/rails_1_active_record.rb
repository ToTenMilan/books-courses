# gems/activerecord-1.0.0/lib/active_record/base.rb
​module​ ActiveRecord
  ​class​ Base
    ​def​ initialize(attributes = nil)
      @attributes = attributes_from_column_definition
      ​# ...​
    ​end​

    ​def​ attribute_names
      @attributes.keys.sort
    ​end​

    alias_method :respond_to_without_attributes?, :respond_to?

    ​def​ respond_to?(method)
      @@dynamic_methods ||= attribute_names +
                            attribute_names.collect { |attr| attr + ​"="​ } +
                            attribute_names.collect { |attr| attr + ​"?"​ }
      @@dynamic_methods.include?(method.to_s) ?
                                              true :
                                              respond_to_without_attributes?(method)
    ​end​
    
    ​def​ method_missing(method_id, *arguments)
      method_name = method_id.id2name
      ​if​ method_name =~ read_method? && @attributes.include?($1)
        ​return​ read_attribute($1)
      ​elsif​ method_name =~ write_method?
        write_attribute($1, arguments[0])
      ​elsif​ method_name =~ query_method?
        ​return​ query_attribute($1)
      ​else​
        ​super​
      ​end​
    ​end​

    ​def​ read_method?()  /^([a-zA-Z][-_\w]*)[^=?]*$/ ​end​
    ​def​ write_method?() /^([a-zA-Z][-_\w]*)=.*$/    ​end​
    ​def​ query_method?() /^([a-zA-Z][-_\w]*)\?$/     ​end​
    ​def​ read_attribute(attr_name)         ​# ...​
    ​def​ write_attribute(attr_name, value) ​#...​
    ​def​ query_attribute(attr_name)        ​# ...