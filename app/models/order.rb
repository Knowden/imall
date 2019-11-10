class Order < ApplicationRecord
  belongs_to :item
  belongs_to :user
  belongs_to :order_state

  validates :amount, presence: true
  validates :amount, numericality: { greater_than: 0 }
end
