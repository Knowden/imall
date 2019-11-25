class StoreController < ApplicationController
  before_action :check_login
  before_action :check_permission, only: [:store_orders, :store_items] # 用户只能查看自己的店铺

  def show_all_stores
    @stores = Store.where(user_id: session[:current_user]["id"])
  end

  def store_orders
    @orders = Order.joins(:item)
                  .where(order_state_id: 1)
                  .where("items.store_id = #{store_params[:store_id]}")
    @current_store_id = store_params[:store_id]
  end

  def store_items
    @items = Item.where(store_id: store_params[:store_id])
    @current_store_id = store_params[:store_id]
  end

  def show_create_store_page
    @store = Store.new
  end

  def create_store
    @store = Store.new(name: store_params[:store_name],
                       user_id: session[:current_user]["id"])
    if @store.save
      redirect_to stores_path
    else
      render :show_create_store_page
    end
  end

  private
  def store_params
    params.permit(:store_id, :store_name)
  end

  def check_login
    redirect_to sign_in_url if session[:current_user].nil?
  end

  # 在用户查看店铺信息前，需要检验店铺是否属于当前用户
  def check_permission
    store = Store.where(id: store_params[:store_id],
                        user_id: session[:current_user]["id"])
    if store.empty?
      redirect_to "/404.html"
    end
  end
end
