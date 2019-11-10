class Order < ApplicationRecord
  belongs_to :item
  belongs_to :user

  validates :amount, presence: true
  validates :amount, numericality: { greater_than: 0 }
end
