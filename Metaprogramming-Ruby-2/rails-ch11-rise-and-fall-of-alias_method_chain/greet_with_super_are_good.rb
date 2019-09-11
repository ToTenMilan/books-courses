module Greetings
  def greet
    'hello'
  end
end

module EnthusiasticGreetings
  def greet
    "Hey, #{super}!"
  end
end

class MyClass
  include EnthusiasticGreetings
end

p MyClass.new.greet

##### gems/activerecord-4.1.0/lib/active_record/validations.rb
# ​module​ ActiveRecord
#   ​module​ Validations
#     ​# The validation process on save can be skipped by passing​
#     ​# <tt>validate: false</tt>.​
#     ​# The regular Base#save method is replaced with this when the​
#     ​# validations module is mixed in, which it is by default.​
#     ​def​ save(options={})
#       perform_validations(options) ? ​super​ : false
#     ​end​
#     ​# Attempts to save the record just like Base#save but will raise​
#     ​# a +RecordInvalid+ exception instead of returning +false+ if​
#     ​# the record is not valid.​
#     ​def​ save!(options={})
#       perform_validations(options) ? ​supe
r​ : raise(RecordInvalid.new(self))
#     ​end​
#     ​def​ perform_validations(options={})
#       ​# ...