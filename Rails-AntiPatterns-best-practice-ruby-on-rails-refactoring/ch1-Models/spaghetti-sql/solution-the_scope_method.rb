# Antipattern
class RemoteProcess < ActiveRecord::Base
  def self.find_top_running_processes(limit = 5)
    find(
      :all,
      conditions: "state = 'running'",
      order: 'percent_cpu desc',
      limit: limit
    )
  end

  def self.find_top_running_system_processes(limit = 5)
    find(
      :all,
      conditions: "state = 'running' and owner in ('root', 'mysql')",
      order: 'percent_cpu desc',
      limit: limit
    )
  end
end



# solution 1
class RemoteProcess < ActiveRecord::Base
  scope :running, -> { where(state: 'running') }
  scope :system, -> { where(owner: ['root', 'mysql']) }
  scope :sorted, -> { order("percnet_cpu desc") }
  scope :top, -> { |l| limit(l) }

  def self.find_top_running_processes(limit = 5)
    running.sorted.top(limit)
  end

  def self.find_top_running_system_processes(limit = 5)
    running.system.sorted.top(limit)
  end
end



# Antipattern 2
class Song < ActiveRecord::Base
  def self.search(title, artist, genre, published, order, limit, page)
    condition_values = { ... }

    case order
    when ...
      ...
    when ...
      ...
    else ...
      ...
    end

    joins = []
    conditions = []
    conditions << "(tilte like ':title'" unless title.blank?
    conditions << ...
    conditions << ...

    unless plublished.blank?
      conditions << ...
    end

    find_opts = { ... }
    page = 1 if page.blank?
    paginate(:all, find_opts.merge(page, per_page))
  end
end



# solution 2
class Song < ActiveRecord::Base
  def self.top(num)
    limit(num)
  end

  def self.matching(column, value)
    where(["#{column} like ?", "%#{value}%"])
  end

  def self.published
    where("published_on is not null")
  end

  def self.order(col)
    sql = case col
      when "name": "name desc"
      when ...: ...
      when ...: ...
      else ...
    end
    order(sql)
  end

  def self.search(title, artist, genre, published)
    finder = matching(:title, title)
    finder = finder.matching(:artist, artist)
    finder = finder.matching(:genre, genre)
    finder = finder.published unless published.blank?
    finder
  end
end

Song.search('fool', 'billy', 'rock', true).
  order('length').
  top(10).
  paginate(page: 1)
