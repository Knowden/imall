class User < ApplicationRecord
  has_many :orders
  has_and_belongs_to_many :payments, through: :user_payments
  has_many :stores
  has_many :comments
  has_many :carts

  validates :name,     uniqueness: true
  validates :name,     presence: true
  validates :password, presence: true
end
