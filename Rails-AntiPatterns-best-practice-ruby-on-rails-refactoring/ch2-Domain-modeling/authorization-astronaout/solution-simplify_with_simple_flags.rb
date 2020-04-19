# Antipattern
class User < ActiveRecord::Base
  has_and_belongs_to_many :roles

  # methods similar to below are often written upfront, with no requirement. They often end unused
  def has_role?(role)
    # ...
  end

  def has_roles?(roles)
    # ...
  end

  def can_post?
    self.has_roles?([...])
  end

  def can_review_post?
    self.has_roles?([...])
  end

  def can_edit_content?
    self.has_roles?([...])
  end
end

class Role < ActiveRecord::Base
  has_and_belongs_to_many :users

  def name=(value)
    # ...
  end

  def self.[](name) # eg. usage Role[:admin]
    # ...
  end

  def add_user(user)
    # ...
  end

  def delete_user(user)
    # ...
  end
end



# solution 1
class User < ActiveRecord::Base
  # no code here, no `Role` model, use boolean column flags i.e. `admin?``, `editor?` etc.
end



# solution 2
class User < ActiveRecord::Base
  has_many :roles
end

class Role < ActiveRecord::Base
  TYPES = %w(admin editor writer guest)

  validate :name, inclusion: { in: TYPES }

  class << self
    TYPES.each do |role_type|
      define_method "#{role_type}?" do
        exists?(name: role_type)
      end
    end
  end
end

# usage
user.roles.admin?
