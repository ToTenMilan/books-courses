class Account
  attr_accessor :name, :balance

  def initialize(name, balance)
    @name = name
    @balance = balance
  end

  def <=>(other) # for sort method
    balance <=> other.balance
  end
end

class Portfolio
  include Enumerable

  def initialize
    @accounts = []
  end

  def each(&block) # every class including Enumerable MUST implement this to use it fully
    @accounts.each(&block)
  end

  def add_account(account)
    @accounts << account
  end
end

acc1 = Account.new('john', 100)
acc2 = Account.new('betsy', 200)
acc3 = Account.new('wacko', 1000)

pf = Portfolio.new
pf.add_account(acc1)
pf.add_account(acc3)
pf.add_account(acc2)

puts pf.any? { |acc| acc.balance > 500 }
puts pf.all? { |acc| acc.balance > 150 }

pf.each { |acc| puts acc.balance }
puts pf = pf.sort
pf.each { |acc| puts acc.balance }