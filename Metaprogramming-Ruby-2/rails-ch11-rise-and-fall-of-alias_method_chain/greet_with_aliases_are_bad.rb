module Greetings
  def greet
    'hello'
  end
end

# class MyClass
#   include Greetings
# end

# MyClass.new.greet

class MyClass
  include Greetings

  def greet_with_enthusiasm
    "Hey, #{greet_without_enthusiasm}!"
  end

  alias_method :greet_without_enthusiasm, :greet # alias of original greet
  alias_method :greet, :greet_with_enthusiasm # greet will be with enthusiasm by default
  # to greet normally call :greet_without_enthusiasm
end

p MyClass.new.greet # => 'Hey, hello!'
p MyClass.new.greet_without_enthusiasm # => 'hello'


##### gems/activesupport-4.1.0/lib/active_support/core_ext/module/aliasing.rb
# ​class​ Module
#   ​def​ alias_method_chain(target, feature)
#     ​# Strip out punctuation on predicates or bang methods since​
#     ​# e.g. target?_without_feature is not a valid method name.​
#     aliased_target, punctuation = target.to_s.sub(/([?!=])$/, ​''​), $1
#     ​yield​(aliased_target, punctuation) ​if​ block_given?
#     with_method = ​"​#{aliased_target}​_with_​#{feature}#{punctuation}​"​
#     without_method = ​"​#{aliased_target}​_without_​#{feature}#{punctuation}​"​
#     alias_method without_method, target
#     alias_method target, with_method
#     ​case​
#     ​when​ public_method_defined?(without_method)
#       public target
#     ​when​ protected_method_defined?(without_method)
#       protected target
#     ​when​ private_method_defined?(without_method)
#       private target
#     ​end​
#   ​end​
# ​end