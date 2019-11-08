class User < ApplicationRecord
  has_many :orders
  has_and_belongs_to_many :payments, through: :user_payments
  has_many :stores
  has_many :history_orders
  has_many :comments
  has_many :carts
end
