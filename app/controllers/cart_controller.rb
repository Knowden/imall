class CartController < ApplicationController

  # 展示当前用户的所有购物车条目
  def show_carts
    @carts = Cart.where user_id: session[:current_user]["id"]
  end

  # 接收参数，新建购物车条目
  def new_cart

  end

  private
  def cart_params
    params.permit(:parches_amount)
  end
end
