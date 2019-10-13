#*******************************************************************************
# --- Implementacja Blockchain II ---
# * Użycie:
#      ruby blockchain3_with_proof_of_work.rb
#*******************************************************************************
require "digest"      # hash checksum digest function SHA256
require "pp"      

class Block
  attr_reader :index
  attr_reader :timestamp
  attr_reader :data
  attr_reader :previous_hash
  attr_reader :nonce  # proof of work
  attr_reader :hash

  def initialize(index, data, previous_hash)
    @index         = index
    @timestamp     = Time.now
    @data          = data
    @previous_hash = previous_hash
    @nonce, @hash  = compute_hash_with_proof_of_work
  end # initialize

  def compute_hash_with_proof_of_work(difficulty="00ab")
    nonce = 0
    loop do
      hash = calc_hash_with_nonce( nonce )
      if hash.start_with?( difficulty )
        return [nonce,hash] # proof of work jeśli rozpoczyna się od 00ab
      else
        nonce += 1 
      end
    end
  end # compute_hash_with_proof_of_work

  def calc_hash_with_nonce(nonce=0)
    sha = Digest::SHA256.new
    sha.update( nonce.to_s + @index.to_s + @timestamp.to_s + @data + @previous_hash )
    sha.hexdigest
  end # calc_hash_with_nonce

  def self.first(data="Genesis")  
    # uses index zero (0) and arbitrary previous_hash ("0")
    Block.new( 0, data, "0" )
  end # first
  
  def self.next( previous, data="Transaction Data..." )
    Block.new( previous.index+1, data, previous.hash )
  end # next
end # Block

#
# --- Budowanie łańcucha bloków ---
#
b0 = Block.first( "Genesis" )
b1 = Block.next( b0, "Transaction Data..." )
b2 = Block.next( b1, "Transaction Data......" )
b3 = Block.next( b2, "More Transaction Data..." )
blockchain = [b0, b1, b2, b3]
pp blockchain

#
#  --- Przykładowy wydruk ---
#
# [#<Block:0x1e204f0
#   @data="Genesis",
#   @hash="00b8e77e27378f9aa0afbcea3a2882bb62f6663771dee053364beb1887e18bcf",
#   @index=0,
#   @nonce=242,
#   @previous_hash="0",
#   @timestamp=2017-09-20 20:13:38 +0200>,
#  #<Block:0x1e56e20
#   @data="Transaction Data...",
#   @hash="00aae8d2e9387e13c71b33f8cd205d336ac250d2828011f5970062912985a9af",
#   @index=1,
#   @nonce=46,
#   @previous_hash=
#    "00b8e77e27378f9aa0afbcea3a2882bb62f6663771dee053364beb1887e18bcf",
#   @timestamp=2017-09-20 20:13:38 +0200>,
#  #<Block:0x1e2bd58
#   @data="Transaction Data......",
#   @hash="00ea45e0f4683c3bec4364f349ee2b6816be0c9fd95cfd5ffcc6ed572c62f190",
#   @index=2,
#   @nonce=350,
#   @previous_hash=
#    "00aae8d2e9387e13c71b33f8cd205d336ac250d2828011f5970062912985a9af",
#   @timestamp=2017-09-20 20:13:38 +0200>,
#  #<Block:0x1fa8338
#   @data="More Transaction Data...",
#   @hash="00436f0fca677652963e904ce4c624606a255946b921132d5b1f70f7d86c4ab8",
#   @index=3,
#   @nonce=59,
#   @previous_hash=
#    "00ea45e0f4683c3bec4364f349ee2b6816be0c9fd95cfd5ffcc6ed572c62f190",
#   @timestamp=2017-09-20 20:13:38 +0200>]