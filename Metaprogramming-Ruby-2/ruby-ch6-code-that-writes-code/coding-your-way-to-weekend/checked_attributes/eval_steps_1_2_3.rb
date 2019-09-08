require 'test/unit'

class Person; end

class TestCheckedAttribute < Test::Unit::TestCase
  def setup
    ####### test suite for step 3
    add_checked_attribute(Person, :age) {|v| v >= 18 } # validation.call(value) injects 17 as v here
    @bob = Person.new
    ####### test suite for step 1 & 2
    # add_checked_attribute(Person, :age)
    # @bob = Person.new
  end

  def test_accepts_valid_values
    @bob.age = 20
    assert_equal 20, @bob.age
  end

  def test_refuses_nil_values
    ####### test suite for step 3
    assert_raises RuntimeError, 'Invalid attribute' do
      @bob.age = 17 # `age=` method accepts block. In this case its `17 > 18` => false
    end
    ####### test suite for step 1 & 2
    # assert_raises RuntimeError, 'Invalid attribute' do
    #   @bob.age = false
    # end
  end
end

def add_checked_attribute(klass, attribute, &validation)
  ####### step 3 - support flexible validations through block
  instance_var_attr = "@#{attribute}".to_sym
  klass.class_eval do
    define_method attribute do
      instance_variable_get(instance_var_attr)
    end
  end

  klass.class_eval do
    define_method "#{attribute}=" do |value|
      raise 'Invalid attribute' unless validation.call(age) # guard validation
      instance_variable_set(instance_var_attr, value)
    end

    # i.e.
    # def age=(age, &validation)
    #   raise 'Invalid attribute' unless validation.call(value) # validation in this case is { |v| v > 18 }.call(17), so 17 > 18
    #   @age = age
    # end
  end

  ######## step 2 - refactor to not use `eval()`
  # instance_var_attr = "@#{attribute}".to_sym
  # klass.class_eval do
  #   define_method attribute do
  #     instance_variable_get(instance_var_attr)
  #   end
  # end

  # klass.class_eval do
  #   define_method "#{attribute}=" do |value|
  #     raise 'Invalid attribute' unless value
  #     instance_variable_set(instance_var_attr, value)
  #   end
  # end

  ######## step 1 - use `eval()`
  # eval <<-end_eval
  #   class #{klass}
  #     def #{attribute}
  #       @#{attribute}
  #     end

  #     def #{attribute}=(value)
  #       raise RuntimeError.new('Invalid attribute') unless value
  #       @#{attribute} = value
  #     end
  #   end
  # end_eval
end