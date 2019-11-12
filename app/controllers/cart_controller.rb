class CartController < ApplicationController
  before_action :check_login

  # 展示当前用户的所有购物车条目
  def show_carts
    @carts = Cart.where user_id: session[:current_user]["id"]
  end

  # 接收参数，新建购物车条目
  # 事务：首先减少商品的库存，然后在当前用户的购物车中创建新的记录
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
    redirect_to cart_url
  end

  # 删除购物车中的某个物品
  # 事务：首先删除当前用户指定的购物车记录，然后将相应的商品库存恢复（增加）
  def remove_cart
    ActiveRecord::Base.transaction do
      # 删除当前用户指定的购物车记录
      cart = Cart.find_by!(id: cart_params[:cart_id])
      cart_amount = cart[:amount]
      item_id = cart[:item_id]
      cart.delete

      # 将相应商品的库存恢复
      item = Item.find_by!(id: item_id)
      item.update!(amount: item[:amount] + cart_amount)
    end
    redirect_to cart_url
  end

  # 支付购物车中的所有物品
  # 事务：对于购物车中的每条记录，删除购物车中的记录并将其转化为订单表中的记录
  def pay_cart
    ActiveRecord::Base.transaction do
      carts = Cart.where(user_id: session[:current_user]["id"])
      carts.each do |cart|
        Order.create!(item_id: cart[:item_id],
                      amount: cart[:amount],
                      user_id: session[:current_user]["id"],
                      order_state_id: 1)
      end
      Cart.where(user_id: session[:current_user]["id"]).delete_all
    end
    redirect_to orders_url
  end

  private
  def cart_params
    params.permit(:parches_amount, :item_id, :cart_id)
  end

  def check_login
    redirect_to sign_in_url if session[:current_user].nil?
  end
end
