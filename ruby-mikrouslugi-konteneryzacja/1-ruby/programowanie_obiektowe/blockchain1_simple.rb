require 'digest'

class Block
  attr_reader :index, :timestamp, :data, :previous_hash, :hash
  def initialize(index:, timestamp: Time.now, data:, previous_hash:)
    @index, @timestamp, @data, @previous_hash = index, timestamp, data, previous_hash
    @hash = Digest::SHA256.hexdigest(index.to_s + timestamp.to_s + data.to_s + previous_hash.to_s)
  end # initialize
end # Block

# Generowanie łańcucha bloków
b0 = Block.new(index: 0, data: 'Genesis', previous_hash: '0')
b1 = Block.new(index: b0.index + 1, data: 'First transaction',  previous_hash: b0.hash)
b2 = Block.new(index: b1.index + 1, data: 'Second transaction', previous_hash: b1.hash)

# Wyświetlanie
[b0, b1, b2].each { |block| p block }
