require 'active_support'

module MyConcern
  extend ActiveSupport::Concern

  def an_instance_method
    'an instance method'
  end

  module ClassMethods
    def a_class_method
      'a class method'
    end
  end
end

class MyClass
  include MyConcern
end

p MyClass.new.an_instance_method # => 'an instance method'
p MyClass.a_class_method # => 'a class method'

# gems/activesupport-4.1.0/lib/active_support/concern.rb
# ​ 	
# ​module​ ActiveSupport
#   ​module​ Concern
#     ​class​ MultipleIncludedBlocks < StandardError ​#:nodoc:​
#       ​def​ initialize
#         ​super​ ​"Cannot define multiple 'included' blocks for a Concern"​
#       ​end​
#     ​end​
#
##### declare @_dependencies (class inst. var.) on includer's class #####
#     ​def​ self.extended(base)
#       base.instance_variable_set(:@_dependencies, [])
#     ​end​
#
# ...
##### override Module#append_features #####
#     def​ append_features(base)
#       if​ base.instance_variable_defined?(:@_dependencies) #### if defined it means it is a Concern
#         base.instance_variable_get(:@_dependencies) << self
#         ​return​ false
#       ​else​ #### if included not by a Concern
#         return​ false ​if​ base < self #### check if already an ancestor of this includer ( base -> Includer, self -> Concern). i.e. $ String < Object # => true
#         @_dependencies.each { |dep| base.send(:include, dep) }
#         ​super​
#         base.extend const_get(:ClassMethods) \
#           ​if​ const_defined?(:ClassMethods)
#         ​# ...​
#       ​end​
#     ​end
#
# ...

# First, modules that extend Concern get an @_dependencies Class Variable.
# Second, they get an override of append_features. 