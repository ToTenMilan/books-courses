module MyModule
  def my_method
    42
  end
end

unbound = MyModule.instance_method(:my_method)
p unbound.class # => UnboundMethod


# bind an UnboundMethod by passing it to Module#define_method
String.class_eval do
  define_method :another_method, unbound
end

p 'abc'.another_method # => 42


# ActiveSupport example of unincluding Loadable#load that is overriding Kernel#load
module Loadable
  def self.exclude_from(base)
    # get original Kernel#load method and bind it to calling class, overriding custom 'load'
    base.class_eval { define_method(:load, Kernel.instance_method(:load)) }
  end
end