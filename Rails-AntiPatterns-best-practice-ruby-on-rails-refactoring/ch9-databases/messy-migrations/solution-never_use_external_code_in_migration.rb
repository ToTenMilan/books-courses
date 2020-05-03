# Antipattern
class AddJobsCountToUser < ActiveRecord::Migration
  def up
    add_column :users, :jobs_count, :integer, default: 0
    User.all.each do |user| # migration is dependent on the current code. What if in X years from now `User` class wont exist?
      user.jobs_count = user.jobs.size
      user.save
    end
  end

  def down
    remove_column :users, :jobs_count
  end
end



# solution
class AddJobsCountToUser < ActiveRecord::Migration
  def up
    add_column :users, :jobs_count, :integer, default: 0
    execute <<-SQL
      UPDATE users SET jobs_count = (
        SELECT count(*) FROM jobs
          WHERE jobs.user_id = users.id
      )
    SQL
  end

  def down
    remove_column :users, :jobs_count
  end
end



# solution - if you REALLY need to use model in migrtion
class AddJobsCountToUser < ActiveRecord::Migration
  class Job < ActiveRecord::Base
  end
  class User < ActiveRecord::Base
    has_many :jobs
  end

  def up
    add_column :users, :jobs_count, :integer, default: 0
    User.reset_column_information # reinspect columns in database after defining models
    User.all.each do |user| # migration is dependent on the current code. What if in X years from now `User` class wont exist?
      user.jobs_count = user.jobs.size
      user.save
    end
  end

  def down
    remove_column :users, :jobs_count
  end
end
