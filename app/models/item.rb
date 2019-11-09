class Item < ApplicationRecord
  belongs_to :store
  has_many :comments

  validates :name, presence: true
  validates :amount, presence: true
  validates :price, presence: true

  validates :amount, numericality: { greater_than_or_equal_to: 0 }
  validates :price, numericality: { greater_than_or_equal_to: 0 }
end
