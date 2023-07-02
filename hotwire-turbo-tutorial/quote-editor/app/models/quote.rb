class Quote < ApplicationRecord
  has_many :line_item_dates, dependent: :destroy
  has_many :line_items, through: :line_item_dates

  belongs_to :company

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

  # [quote.company, 'quotes'] generates signed-stream-name which lets us stream only to the users who are part of company
  broadcasts_to ->(quote) { [quote.company, 'quotes'] }, inserts_by: :prepend

  scope :ordered, -> { order(id: :desc) }

  def total_price
    line_items.sum(&:total_price)
  end
end
