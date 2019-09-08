require 'test/unit'

class Class
  def attr_checked(attribute, &validation)
    instance_var_attr = "@#{attribute}".to_sym
    define_method attribute do
      instance_variable_get(instance_var_attr)
    end

    define_method "#{attribute}=" do |value|
      raise 'Invalid attribute' unless validation.call(value) # guard validation
      instance_variable_set(instance_var_attr, value)
    end
  end
end

class Person
  attr_checked :age do |v|
    v >= 18
  end
end

class TestCheckedAttribute < Test::Unit::TestCase
  def setup
    @bob = Person.new
  end

  def test_accepts_valid_values
    @bob.age = 20
    assert_equal 20, @bob.age
  end

  def test_refuses_nil_values
    assert_raises RuntimeError, 'Invalid attribute' do
      @bob.age = 17 # `age=` method accepts block. In this case its `17 > 18` => false
    end
  end
end
