class OrderController < ApplicationController
  def show_all_orders
    @no_shipped_orders = Order.where(user_id: session[:current_user]["id"], order_state_id: 1)
    @no_comment_orders = Order.where(user_id: session[:current_user]["id"], order_state_id: 2)
    @finish_orders = Order.where(user_id: session[:current_user]["id"], order_state_id: 3)
  end
end
