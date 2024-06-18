class Fulfiller
  # class variables (@num_fulfilled) is not threadsafe

  def start_fulfillment(order)
    self.num_fulfilled = self.num_fulfilled + 1
  end

  def self.num_fulfilled=(new_value)
    @num_fulfilled = new_value
  end

  def self.num_fulfilled
    @num_fulfilled || 0
  end
end
