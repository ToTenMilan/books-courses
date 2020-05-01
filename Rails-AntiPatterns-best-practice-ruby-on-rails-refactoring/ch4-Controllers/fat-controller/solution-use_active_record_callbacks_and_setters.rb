######### Antipattern
class ArticlesController < ApplicationController
  def create
    @article + Article.new(params[:article])
    @article.reporter_id = current_user.id

    begin
      Article.transaction do
        @version = @article.create_version!(params[:version], current_user)
      end
    rescue ActiveRecord::RecordNotFound, ActiveRecord::RecordInvalid
      render action: :new && return false
    end

    redirect_to article_path(@article)
  end
end

# app/models/article.rb
def create_version!(attributes, user)
  if self.versions.empty?
    return create_first_version!(attributes, user)
  end
  # mark old related links as not current
  if self.current_version.relateds.any?
    self.current_version.relateds.each do |rel|
      rel.update_attribute(:current, false)
    end
  end

  # almost the same chunk as in create_first_version!
  version = self.versions.build(attributes)
  version.article_id = self.id
  version.written_at = Time.now # created_at is doing this
  version.writer_id = user.id
  version.version = self.current_version.version + 1 # move to callback
  self.save!
  self.update_attribute(:current_version_id, version.id) # move to callback after_create
  version
end

def create_first_version!(attributes, user)
  version = self.versions.build(attributes)
  version.written_at = Time.now # created_at is doing this
  version.writer_id = user.id
  version.state ||= 'Raw' # set this as database default
  version.version = 1 # move to callback
  self.save!
  self.update_attribute(:current_version_id, version.id) # move to callback after_create
  version
end






######### solution (with steps)
class ArticlesController < ApplicationController
  def create
    @article + Article.new(params[:article])
    @article.reporter = current_user #removed `.id` setting
    # @version = @article.versions.build(params[:version])
    # @version.writer = current_user # removed `.id` setting
    @article.new_version = params[:version] # missed in book
    @article.new_version.writer = current_user

    # begin
    #   # Article.transaction do
    #     @article.save! # dont raise error on invalid save, remove `!`
    #   # end
    # rescue ActiveRecord::RecordNotFound, ActiveRecord::RecordInvalid
    #   render action: :new && return false
    # end
    # redirect_to article_path(@article)

    if @article.save
      render action: :index
    else
      redirect_to article_path(@article)
    end
  end
end

# app/models/version.rb
class Version < ActiveRecord::Base
  before_validation :set_version_number, on: :create
  validates :version, presence: :true

  before_create :mark_related_links_not_current, if: :current_version

  after_create :set_current_version_on_article

  private

  def current_version
    article.current_version
  end

  def set_version_number
    self.version = (current_version ? current_version.version : 0) + 1
  end

  def mark_related_links_not_current
    # if current_version
    # unless article.versions.empty?
      # if article.current_version.relateds.any?
        current_version.relateds.each do |rel|
          rel.update_attribute(:curent, false)
        end
      # end
    # end
  end

  def set_current_version_on_article
    article.update_attribute(:current_version_id, self.id)
  end
end

# app/models/article.rb
class Article < ActiveRecord::Base
  def new_version=(version_attributes)
    @new_version = versions.build(version_attributes)
  end

  def new_version
    @new_version
  end
end







########## solution (cleaned up)
class ArticlesController < ApplicationController
  def create
    @article + Article.new(params[:article])
    @article.reporter = current_user
    @article.new_version = params[:version] # missed in book
    @article.new_version.writer = current_user

    if @article.save
      render action: :index
    else
      redirect_to article_path(@article)
    end
  end
end

# app/models/version.rb
class Version < ActiveRecord::Base
  before_validation :set_version_number, on: :create
  validates :version, presence: :true

  before_create :mark_related_links_not_current, if: :current_version

  after_create :set_current_version_on_article

  private

  def current_version
    article.current_version
  end

  def set_version_number
    self.version = (current_version ? current_version.version : 0) + 1
  end

  def mark_related_links_not_current
    current_version.relateds.each do |rel|
      rel.update_attribute(:curent, false)
    end
  end

  def set_current_version_on_article
    article.update_attribute(:current_version_id, self.id)
  end
end

# app/models/article.rb
class Article < ActiveRecord::Base
  def new_version=(version_attributes)
    @new_version = versions.build(version_attributes)
  end

  def new_version
    @new_version
  end
end


########### ! BE CAREFUL ! ############
# to not overuse or missuse callbacks #
#######################################
