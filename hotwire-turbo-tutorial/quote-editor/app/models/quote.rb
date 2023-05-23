class Quote < ApplicationRecord
  validates :name, presence: true

  # after_create_commit -> {
  #   broadcast_prepend_later_to 'quotes', # should be broadcasted to users subscribed to the "quotes" stream (ensure)
  #   partial: 'quotes/quote',
  #   locals: { quote: self },
  #   target: 'quotes'#, prepended to the DOM node with the id of "quotes" (ensure)
  # }

  # syntactic sugar
  # details:
  # https://www.hotrails.dev/turbo-rails/turbo-streams
  # Turbo Streams conventions and syntactic sugar
  # after_create_commit -> {
  #   broadcast_prepend_to "quotes"
  # }

  # after_update_commit -> {
  #   broadcast_replace_later_to 'quotes'
  # }

  # after_destroy_commit -> {
  #   broadcast_remove_to 'quotes'
  # }

  broadcasts_to ->(quote) { 'quotes' }, inserts_by: :prepend

  scope :ordered, -> { order(id: :desc) }
end
