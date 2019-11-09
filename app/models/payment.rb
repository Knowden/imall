class Payment < ApplicationRecord
  has_and_belongs_to_many :users, through: :user_payments

  validates :name, presence: true
end
