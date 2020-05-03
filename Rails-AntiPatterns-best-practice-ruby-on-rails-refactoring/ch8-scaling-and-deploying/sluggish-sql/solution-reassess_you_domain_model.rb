# Antipattern
class State < ActiveRecord::Base
end

class User < ActiveRecord::Base
end

class Category < ActiveRecord::Base
end

class Article < ActiveRecord::Base
  belongs_to :state
  belongs_to :user
  belongs_to :categories
end

# No eager loading introduces N+1 query
- @articles.each do |article|
  = article.user.name
  = article.category.name
  = article.state.name




# solution
Articles.includes([:state, :user, :categories])

# this will translate to
# SELECT * FROM articles
#   LEFT OUTER JOIN states ON articles.state_id = states.id
#   LEFT OUTER JOIN categories ON articles.category_id = categories.id
#   LEFT OUTER JOIN users ON articles.user_id = users.id




# solution2 - denormalize tables, ramove tables that do not add value, dont have logic, have one column
class Article < ActiveRecord::Base
  enum states: %i[draft review published archived]
  enum categories: %i[tips faqs misc hiking]
end
