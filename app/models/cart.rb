class Cart < ApplicationRecord
  belongs_to :user
  belongs_to :item

  validates :amount, presence: true

  validates :amount, numericality: { greater_than: 0 }
end
