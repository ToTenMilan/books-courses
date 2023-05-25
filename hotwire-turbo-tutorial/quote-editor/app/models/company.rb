class Company < ApplicationRecord
  validates :name, presence: true

  has_many :users, dependent: :destroy
  has_many :quotes, dependent: :destroy
end
