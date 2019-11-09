class CartController < ApplicationController

  # 展示当前用户的所有购物车条目
  def show_carts
    @carts = Cart.where user_id: session[:current_user]["id"]
  end

  # 接收参数，新建购物车条目
  def new_cart
    # 减少库存和创建记录应保持事务性，要么都执行，要么都不执行
    ActiveRecord::Base.transaction do
      # 减少Item表中的库存
      item = Item.find_by!(id: cart_params[:item_id])
      new_amount = item[:amount] - cart_params[:parches_amount].to_i
      item.update!(amount: new_amount)

      # 创建新的购物车记录到当前用户
      cart = Cart.find_by(user_id: session[:current_user]["id"], item_id: cart_params[:item_id])
      if cart.nil?
        Cart.create!(user_id: session[:current_user]["id"],
                     item_id: cart_params[:item_id],
                     amount: cart_params[:parches_amount])
      else
        cart.update!(amount: cart[:amount] + cart_params[:parches_amount].to_i)
      end
    end
  end

  private
  def cart_params
    params.permit(:parches_amount, :item_id)
  end
end
