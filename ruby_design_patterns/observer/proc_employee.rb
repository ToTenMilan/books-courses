module Subject
  attr_reader :observers

  def initialize
    @observers = []
  end

  def add_observer(&o)
    @observers << o
  end

  def remove_observer(o)
    @observers.delete(o)
  end

  def notify_observers
    @observers.each do |o|
      o.call(self)
    end
  end
end

class Employee
  include Subject

  attr_reader :name, :address
  attr_accessor :salary

  def initialize(name, title, salary)
    super()
    @name = name
    @title = title
    @salary = salary
  end

  def salary=(new_salary)
    @salary = new_salary
    notify_observers
  end
end


fred = Employee.new('Fred', 'crane oparator', 30000)
fred.add_observer do |changed_employee|
  puts("cut a new check for #{changed_employee.name}")
  puts("His salary is now #{changed_employee.salary}")
end

fred.salary = 35000

fred.add_observer do |changed_employee|
  puts("Send #{changed_employee.name} a new tax bill")
end

fred.salary = 50000

p fred.observers
