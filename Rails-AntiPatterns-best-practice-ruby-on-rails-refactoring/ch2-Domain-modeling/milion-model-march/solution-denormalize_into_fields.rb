# Antipattern
class Article < ActiveRecord::Base
  belongs_to :state
  belongs_to :category
end

# models that do nothing except representing some name
class State < ActiveRecord::Base
  has_many :articles

  # eg. names: planned, in_progress, done
end

class Category < ActiveRecord::Base
  has_many :articles

  # eg. sport, news, politics
end


# Note since Rails 4.1 there are enum's https://api.rubyonrails.org/classes/ActiveRecord/Enum.html

# solution ( < Rails 4.1)
class Article < ActiveRecord::Base
  STATES = %w(planned in_progress done)
  CATEGORIES = %w(sport news politics)

  STATES.each do |state|
    define_method "#{state}?" do
      exists?(name: state)
    end
  end

  CATEGORIES.each do |category|
    define_method "#{category}?" do
      exists?(name: category)
    end
  end

  class << self
    STATE.each do |state|
      define_method "#{state}" do
        state
      end
    end

    CATEGORIES.each do |category|
      define_method "#{category}" do
        category
      end
    end
  end

end
