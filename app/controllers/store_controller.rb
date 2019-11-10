class StoreController < ApplicationController

  def show_all_stores
    @stores = Store.where(user_id: session[:current_user]["id"])
  end

  def store_detail

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
end
