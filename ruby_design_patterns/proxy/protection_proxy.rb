require 'etc'

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

class AccountProtectionProxy
  def initialize(real_account, owner_name)
    @subject = real_account
    @owner_name = owner_name
  end

  ####### switched off by method_missing
  # def balance
  #   check_access
  #   @subject.balance
  # end

  # def deposit(amount)
  #   check_access
  #   @subject.deposit(amount)
  # end

  # def withdraw(amount)
  #   check_access
  #   @subject.withdraw(amount)
  # end

  def method_missing(name, *args)
    check_access
    @subject.send(name, *args)
  end

  def check_access
    if Etc.getlogin != @owner_name
      puts 'Access denied'
      raise "Illegal access: #{Etc.getlogin} cannot access account."
    end
  end
end

account = BankAccount.new(100)
account.deposit(50)
account.withdraw(10)

# proxy = AccountProtectionProxy.new(account, 'billybob')
# proxy.deposit(50)
# proxy.withdraw(10)
# puts proxy.balance

# proxy = AccountProtectionProxy.new(account, 'johny')


# lolol = AccountProtectionProxy.new('lolol', 'milan')
# puts("The length of the string is #{lolol.length}")

lol = AccountProtectionProxy.new('lol', 'billybob')
puts("The length of the string is #{lol.length}")
