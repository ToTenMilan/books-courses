class Quote < ApplicationRecord
  validates :name, presence: true

  after_create_commit -> {
    broadcast_prepend_to 'quotes', # should be broadcasted to users subscribed to the "quotes" stream (ensure)
    partial: 'quotes/quote',
    locals: { quote: self },
    target: 'quotes'#, prepended to the DOM node with the id of "quotes" (ensure)
  }

  scope :ordered, -> { order(id: :desc) }
end
