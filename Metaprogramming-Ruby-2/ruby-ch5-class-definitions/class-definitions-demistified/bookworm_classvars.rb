class Loan
  def initialize(book)
    @book = book
    @time = Loan.time_class.now
  end

  def self.time_class
    # in production, Time will be returned always
    @time_class || Time # Class Instance Variable (not instance variable)
  end

  def to_s
    "#{@book.upcase} loaned on #{@time}"
  end
end