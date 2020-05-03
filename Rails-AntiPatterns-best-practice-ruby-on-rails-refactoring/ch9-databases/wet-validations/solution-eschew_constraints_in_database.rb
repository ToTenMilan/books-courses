# consider this example
class User < ActiveRecord::Base
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, uniqueness: true,
                    presence: true,
                    format: { with: %r{.+@.+\..+} }
  belongs_to :account
end

# antipattern is to write custom constraints like `format` in migration, because it does not have the same support across databases, and you will be forced to use extra database features to write these constraints

# solution - trust ActiveRecord on such constraints like `format`
# However it is still good to put common constraints in database like i.e. `null` with `default`
add_column :users, :active, :boolean, null: false, default: true
