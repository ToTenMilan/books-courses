class BankAccount # Subject to be proxied
  attr_reader :balance

  def initialize(starting_balance=0)
    @balance = starting_balance
  end

  def deposit(amount)
    @balance += amount
  end

  def withdraw(amount)
    @balance -= amount
  end
end

class VirtualAccountProxy # temp account for customer to fiddle with. If customer decides to make some real action like i.e. deposit money, the real account is being created
  def initialize(&creation_block)
    @creation_block = creation_block
  end

  ####### switched off by method_missing
  # def deposit
  #   s = subject
  #   s.deposit(amount)
  # end

  # def withdraw(amount)
  #   s = subject
  #   s.withdraw(amount)
  # end

  # def balance
  #   s = subject
  #   s.balance
  # end

  def method_missing(name, *args)
    s = subject
    s.send(name, *args)
  end

  def subject
    @subject || (@subject = @creation_block.call)
  end
end

# account = VirtualAccountProxy.new { BankAccount.new(10) }
# puts account.balance

arr = VirtualAccountProxy.new { Array.new }
arr << 'hello'
arr << 'out'
arr << 'there'
puts arr