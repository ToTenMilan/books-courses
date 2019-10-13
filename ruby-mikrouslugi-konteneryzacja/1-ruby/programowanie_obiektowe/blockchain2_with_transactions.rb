#*******************************************************************************
# --- Implementacja Blockchain I ---
#
# * Użycie:
#     ruby blockchain2_with_transactions.rb
# * Transakcje w łańcuchu (bloków) / księdze:
#
# from: Dutchgrown       to: Vincent    what: Tulip Bloemendaal Sunset   qty: 10
# from: Keukenhof        to: Anne       what: Tulip Semper Augustus      qty: 7
#
# from: Flowers          to: Ruben      what: Tulip Admiral van Eijck    qty: 5
# from: Vicent           to: Anne       what: Tulip Bloemendaal Sunset   qty: 3
# from: Anne             to: Julia      what: Tulip Semper Augustus      qty: 1
# from: Julia            to: Luuk       what: Tulip Semper Augustus      qty: 1
#
# from: Bloom & Blossom  to: Daisy      what: Tulip Admiral of Admirals  qty: 8
# from: Vincent          to: Max        what: Tulip Bloemendaal Sunset   qty: 2
# from: Anne             to: Martijn    what: Tulip Semper Augustus      qty: 2
# from: Ruben            to: Julia      what: Tulip Admiral van Eijck    qty: 2
#
# from: Teleflora        to: Max        what: Tulip Red Impression       qty: 11
# from: Anne             to: Naomi      what: Tulip Bloemendaal Sunset   qty: 1
# from: Daisy            to: Vincent    what: Tulip Admiral of Admirals  qty: 3
# from: Julia            to: Mina       what: Tulip Admiral van Eijck    qty: 1
#
# from: Max              to: Isabel     what: Tulip Red Impression       qty: 2
#
# (źródło: tulips on the blockchain - public distributed (hyper) ledger
#    @ github.com/openblockchains/tulips )
#*******************************************************************************

require "digest"    # hash checksum digest function SHA256
require "pp"

class Block
  attr_reader :index
  attr_reader :timestamp
  attr_reader :transactions
  attr_reader :transactions_count
  attr_reader :previous_hash
  attr_reader :hash

  def initialize(index, transactions, previous_hash)
    @index              = index
    @timestamp          = Time.now.utc
    @transactions       = transactions
    @transactions_count = transactions.size
    @previous_hash      = previous_hash
    @hash               = calc_hash
  end # initialize

  def calc_hash
    sha = Digest::SHA256.new
    sha.update( @index.to_s +
                @timestamp.to_s +
                @transactions_count.to_s +
                @transactions.to_s +
                @previous_hash )
    sha.hexdigest
  end # calc_hash

  # Operator * konwertuje listę w tablicę
  def self.first( *transactions ) 
    # Początek łańcucha
    Block.new( 0, transactions, "0" )
  end # first

  def self.next( previous, *transactions )
    Block.new( previous.index+1, transactions, previous.hash )
  end # next
end # Block

#
# -- Budowanie łańcucha bloków ---
# 
b0 = Block.first(
        { from: "Dutchgrown", to: "Vincent", what: "Tulip Bloemendaal Sunset", qty: 10 },
        { from: "Keukenhof",  to: "Anne",    what: "Tulip Semper Augustus",    qty: 7  } )
b1 = Block.next( b0,
        { from: "Flowers", to: "Ruben", what: "Tulip Admiral van Eijck",  qty: 5 },
        { from: "Vicent",  to: "Anne",  what: "Tulip Bloemendaal Sunset", qty: 3 },
        { from: "Anne",    to: "Julia", what: "Tulip Semper Augustus",    qty: 1 },
        { from: "Julia",   to: "Luuk",  what: "Tulip Semper Augustus",    qty: 1 } )
b2 = Block.next( b1,
        { from: "Bloom & Blossom", to: "Daisy",   what: "Tulip Admiral of Admirals", qty: 8 },
        { from: "Vincent",         to: "Max",     what: "Tulip Bloemendaal Sunset",  qty: 2 },
        { from: "Anne",            to: "Martijn", what: "Tulip Semper Augustus",     qty: 2 },
        { from: "Ruben",           to: "Julia",   what: "Tulip Admiral van Eijck",   qty: 2 } )
b3 = Block.next( b2,
        { from: "Teleflora", to: "Max",     what: "Tulip Red Impression",      qty: 11 },
        { from: "Anne",      to: "Naomi",   what: "Tulip Bloemendaal Sunset",  qty: 1  },
        { from: "Daisy",     to: "Vincent", what: "Tulip Admiral of Admirals", qty: 3  },
        { from: "Julia",     to: "Mina",    what: "Tulip Admiral van Eijck",   qty: 1  } )
blockchain = [b0, b1, b2, b3]
pp blockchain

#
#  --- Przykładowy wydruk ---
#
# [#<Block:0x2da3da0
#   @hash="32bd169baebba0b70491b748329ab631c85175be15e1672f924ca174f628cb66",
#   @index=0,
#   @previous_hash="0",
#   @timestamp=2017-09-24 11:40:15 UTC,
#   @transactions=
#    [{:from=>"Dutchgrown", :to=>"Vincent", :what=>"Tulip Bloemendaal Sunset", :qty=>10},
#     {:from=>"Keukenhof",  :to=>"Anne",    :what=>"Tulip Semper Augustus",    :qty=>7}],
#   @transactions_count=2>,
#  #<Block:0x2da2ff0
#   @hash="57b519a8903e45348ac8a739c788815e2bd90423663957f87e276307f77f1028",
#   @index=1,
#   @previous_hash=
#    "32bd169baebba0b70491b748329ab631c85175be15e1672f924ca174f628cb66",
#   @timestamp=2017-09-24 11:40:15 UTC,
#   @transactions=
#    [{:from=>"Flowers", :to=>"Ruben", :what=>"Tulip Admiral van Eijck",  :qty=>5},
#     {:from=>"Vicent",  :to=>"Anne",  :what=>"Tulip Bloemendaal Sunset", :qty=>3},
#     {:from=>"Anne",    :to=>"Julia", :what=>"Tulip Semper Augustus",    :qty=>1},
#     {:from=>"Julia",   :to=>"Luuk",  :what=>"Tulip Semper Augustus",    :qty=>1}],
#   @transactions_count=4>,
#  #<Block:0x2da2720
#   @hash="ec7dd5ea86ab966d4d4db182abb7aa93c7e5f63857476e6301e7e38cebf36568",
#   @index=2,
#   @previous_hash=
#    "57b519a8903e45348ac8a739c788815e2bd90423663957f87e276307f77f1028",
#   @timestamp=2017-09-24 11:40:15 UTC,
#   @transactions=
#    [{:from=>"Bloom & Blossom", :to=>"Daisy",   :what=>"Tulip Admiral of Admirals", :qty=>8},
#     {:from=>"Vincent",         :to=>"Max",     :what=>"Tulip Bloemendaal Sunset",  :qty=>2},
#     {:from=>"Anne",            :to=>"Martijn", :what=>"Tulip Semper Augustus",     :qty=>2},
#     {:from=>"Ruben",           :to=>"Julia",   :what=>"Tulip Admiral van Eijck",   :qty=>2}],
#   @transactions_count=4>,
#  #<Block:0x2da1ee0
#   @hash="a1c5e5035403214a7349c2dedb7858ed411a351d7cb23d196583687a9a019785",
#   @index=3,
#   @previous_hash=
#    "ec7dd5ea86ab966d4d4db182abb7aa93c7e5f63857476e6301e7e38cebf36568",
#   @timestamp=2017-09-24 11:40:15 UTC,
#   @transactions=
#    [{:from=>"Teleflora", :to=>"Max",     :what=>"Tulip Red Impression",      :qty=>11},
#     {:from=>"Anne",      :to=>"Naomi",   :what=>"Tulip Bloemendaal Sunset",  :qty=>1},
#     {:from=>"Daisy",     :to=>"Vincent", :what=>"Tulip Admiral of Admirals", :qty=>3},
#     {:from=>"Julia",     :to=>"Mina",    :what=>"Tulip Admiral van Eijck",   :qty=>1}],
#   @transactions_count=4>]