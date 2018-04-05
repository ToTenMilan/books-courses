class Task # component
  attr_accessor :name, :parent

  def initialize(name)
    @name = name
    @parent = nil
  end

  def get_time_required
    0.0
  end
end

class AddDryIngredientsTask < Task
  def initialize
    super('Add dry ingredients')
  end

  def get_time_required
    1.0 # 1 minute to add floor and sugar
  end
end

class MixTask < Task
  def initialize
    super('mix that batter up')
  end
  
  def get_time_required
    3.0 # mix time
  end
end

class AddLiquidsTask < Task
  def initialize
    super('add liquids')
  end
  
  def get_time_required
    3.0 # mix time
  end
end



class CompositeTask < Task
  def initialize(name)
    super(name)
    @subtasks = []
  end
  
  def add_subtask(task)
    @subtasks << task
    task.parent = self
  end

  def [](index)
    @subtasks[index]
  end

  def []=(index, new_value)
    @subtasks[index] = new_value
  end

  def remove_subtask(task)
    @subtasks.delete(task)
    task.parent = nil
  end

  def get_time_required
    time=0.0
    @subtasks.each { |t| time += t.get_time_required}
    time
  end
end

class MakeBatterTask < CompositeTask
  def initialize
    super('make batter')
    add_subtask( AddDryIngredientsTask.new )
    add_subtask( AddLiquidsTask.new )
    add_subtask( MixTask.new)
  end
end

class MakeCakeTask < CompositeTask
  def initialize
    super('Make cake')
    add_subtask( MakeBatterTask.new )
    add_subtask( FillPanTask.new )
    add_subtask( BakeTask.new )
    add_subtask( FrostTask.new )
    add_subtask( LickSpoonTask.new )
  end
end

composite = CompositeTask.new('example')
composite.add_subtask MixTask.new

puts composite[0].get_time_required
composite[1] = AddDryIngredientsTask.new

p composite
p '======='
# task = AddDryIngredientsTask.new
while composite
  puts("composite: #{composite}")
  tcomposite = composite.parent
end