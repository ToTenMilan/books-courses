# Antipattern
class ArticlesController < ApplicationController
  def index
    # controller needs to know too much about `Article` model
    @featured_articles = Article.
      with_at_least_one_comment.
      with_votes_at_least(Article::MIN_VOTES_TO_DISPLAY).
      created_after(Article::FEATURED_CUTOFF_AGE.ago)
  end
end

class Article < ActiveRecord::Base
  MIN_VOTES_TO_DISPLAY = 4
  FEATURED_CUTOFF_AGE = 7.days
  scope :with_at_least_one_comment, where('articles.comments_count > 0')

  def with_votes_at_least(...)
    where(...)
  end

  def created_after(...)
    where(...)
  end
end

class ArticlesControllerTest < ActionController::TestCase
  context "given featured articles" do
    # too much mocking
    setup do
      chain = stub('chain')
      @featured_articles = [create(:article), create(:article)]
      Article.stubs(:with_at_least_one_comment).returns(chain)
      chain.
        stubs(:with_votes_at_least).with(Article::MIN_VOTES_TO_DISPLAY).returns(chain)
      chain.
        stubs(:created_after).with(Article::FEATURED_CUTOFF_AGE.ago).returns(@featured_articles)
    end

    context "on GET index" do
      setup { gete :index }
      it assigns_to(:featured_articles).with { @featured_articles}
    end
  end
end



# solution - move featured article logic to scope (or class method)
class ArticlesController < ApplicationController
  def index
    @featured_articles = Article.featured
  end
end

class Article < ActiveRecord::Base
  MIN_VOTES_TO_DISPLAY = 4
  FEATURED_CUTOFF_AGE = 7.days
  scope :with_at_least_one_comment, where('articles.comments_count > 0')

  def self.featured
    with_at_least_one_comment.
      with_votes_at_least(Article::MIN_VOTES_TO_DISPLAY).
      created_after(Article::FEATURED_CUTOFF_AGE.ago)
  end

  def with_votes_at_least(...)
    where(...)
  end

  def created_after(...)
    where(...)
  end
end

class ArticlesControllerTest < ActionController::TestCase
  context "given featured articles" do
    setup do
      @featured_articles = [create(:article), create(:article)]
      Article.stubs(:featured).returns(@featured_articles)
    end

    context "on GET index" do
      setup { gete :index }
      it assigns_to(:featured_articles).with { @featured_articles}
    end
  end
end
