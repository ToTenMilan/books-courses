require 'observer'

class Employee
  include Observable

  attr_reader :name
  attr_accessor :salary, :title

  def initialize(name, title, salary)
    super() # the only case in Ruby in which parentheses are needed. This way init in superclass is called without parameters (instead of three)
    @name = name
    @title = title
    @salary = salary
  end

  def salary=(new_salary)
    old_salary = @salary
    @salary = new_salary
    if old_salary != new_salary # --> dont notify if nothing has changed
      changed
      notify_observers(self)
    end
  end
end


# OBSERVER pattern 2nd try
# module Subject
#   def initialize
#     @observers = []
#   end

#   def add_observer(o)
#     @observers << o
#   end

#   def remove_observer(o)
#     @observers.delete(o)
#   end

#   def notify_observers
#     @observers.each do |o|
#       o.update(self)
#     end
#   end
# end

# class Employee
#   include Subject

#   attr_reader :name, :address
#   attr_accessor :salary

#   def initialize(name, title, salary)
#     super()
#     @name = name
#     @title = title
#     @salary = salary
#   end

#   def salary=(new_salary)
#     @salary = new_salary
#     notify_observers
#   end
# end



# OBSERVER pattern 1st try
# class Employee
#   attr_reader :name, :title
#   attr_accessor :salary

#   def initialize(name, title, salary)
#     @name = name
#     @title = title
#     @salary = salary
#     @observers = []
#   end

#   def salary=(new_salary)
#     @salary = new_salary
#     notify_observers
#   end

#   def notify_observers
#     @observers.each do |observer|
#       observer.update(self)
#     end
#   end

#   def add_observer(observer)
#     @observers << observer
#   end

#   def remove_observer(observer)
#     @observers.delete(observer)
#   end
# end

class Payroll
  def update(changed_employee)
    puts("cut a new check for #{changed_employee.name}")
    puts("His salary is now #{changed_employee.salary}")
  end
end

class TaxMan
  def update(changed_employee)
    puts("Send #{changed_employee.name} a new tax bill")
  end
end

fred = Employee.new('Fred', 'crane oparator', 30000)
payroll = Payroll.new
fred.add_observer(payroll)

fred.salary = 35000

tax_man = TaxMan.new
fred.add_observer(tax_man)

fred.salary = 50000
