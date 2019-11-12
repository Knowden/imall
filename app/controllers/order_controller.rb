class OrderController < ApplicationController
  before_action :check_login

  def show_all_orders
    @no_shipped_orders = Order.where(user_id: session[:current_user]["id"], order_state_id: 1)
    @no_comment_orders = Order.where(user_id: session[:current_user]["id"], order_state_id: 2)
    @finish_orders = Order.where(user_id: session[:current_user]["id"], order_state_id: 3)
  end

  def send_order
    Order.where(id: order_params[:order_id]).update(order_state_id: 2)
    redirect_back(fallback_location: root_url)
  end

  private
  def order_params
    params.permit(:order_id)
  end

  def check_login
    redirect_to sign_in_url if session[:current_user].nil?
  end

end
