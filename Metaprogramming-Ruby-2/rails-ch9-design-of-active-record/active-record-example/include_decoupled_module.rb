require 'active_model'

class User
  include ActiveModel::Validations

  attr_accessor :password

  validate do
    errors.add(:base, 'dont do abc123') if password == 'abc123'
  end
end

user = User.new
user.password = 'superhard'
user.valid? # => true

user.password = 'abc123'
user.valid? # => false