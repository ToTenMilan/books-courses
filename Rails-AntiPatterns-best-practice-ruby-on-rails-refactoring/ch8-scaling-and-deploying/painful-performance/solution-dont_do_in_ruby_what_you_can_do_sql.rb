# Example 1 - Learn which methods operates in SQL, and which in Ruby:
article.comments.count # operates on SQL level and is fast, because is not loading data
article.comments.length # oparates on Ruby level, so after loading all comments. Is slow with larga amount of data
article.comments.size # call `length` if collection is present, otherwise calls `count`


# Example 2 - do not use `sort` where you could use `order`
account = Account.find(3)
users = account.users.sort { # sort is loading all users from db, which is not needed
  |a,b| a.name.downcase <=> b.name.downcase # downcasing means copying strings into memory, so memory usage is doubled in this code
}.first(5)

# solution
users = account.users.order('LCASE(name)').limit(5)


# Example 3
class Article < ActiveRecord::Base
  has_many :comments
  has_many :users, through: :comments
end

class Comment < ActiveRecord::Base
  belongs_to :article
  belongs_to :user
end

class User < ActiveRecord::Base
  has_many :comments
  has_many :articles, through: :comments

  def collaborators # problems: redundant data loaded, redundant Ruby logic executed
    articles.collect { # load every article user has commented on
      |a| a.users # load every users of these articles
    }.flatten.uniq.reject { # remove duplicates
      |u| u == self # compare every user to self
    }
  end
end

# solution
class User < ActiveRecord::Base
  has_many :comments
  has_many :articles, through: :comments

  def collaborators
    User.select("DISTINCT users.*").
      joins(comments: [:user, { article: :comments }]).
      where(["articles.id IN ? AND users.id != ?", self.article_ids, self.id])

    # this translates to:
    # SELECT DISTINCT users.* FROM users                                                    # select all columns
    #   INNER JOIN comments ON comments.user_id = users.id                                  # joins(:comments)                         # join caller comments
    #   INNER JOIN users users_comments ON users_comments.id = comments.user_id             # joins(comments: [:user])                 # join commenters of caller's comments
    #   INNER JOIN articles ON comments.article_id = articles.id                            # joins(comments: [:article])              # join articles of caller's comments
    #   INNER JOIN comments comments_articles ON comments_articles.article_id = articles.id # joins(comments: [{ article: :comment }]) # join all comments of all articles of caller's comments
    #   WHERE (articles.id in (1) AND users.id != 2)
  end
end
