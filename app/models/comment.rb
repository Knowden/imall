class Comment < ApplicationRecord
  belongs_to :item
  belongs_to :user

  validates :content, presence: true
  validates :create_date, presence: true
end
