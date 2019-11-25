class Item < ApplicationRecord
  belongs_to :store
  has_many :comments

  validates :name, presence: true
  validates :amount, presence: true
  validates :price, presence: true

  validates :amount, numericality: { greater_than_or_equal_to: 0 }
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  before_destroy do
    throw :abort if have_orders_not_handle?
    ActiveRecord::Base.transaction do
      self.delete_cart_of_item
      self.delete_comment_of_item
      self.delete_orders_of_item
    end
  end

  def have_orders_not_handle?
    orders = Order.where(item_id: self.id, order_state_id: 1)
    not orders.empty?
  end

  def delete_cart_of_item
    Cart.where(item_id: self.id).destroy_all
  end

  def delete_comment_of_item
    Comment.where(item_id: self.id).destroy_all
  end

  def delete_orders_of_item
    Order.where(item_id: self.id).destroy_all
  end
end
