class ItemController < ApplicationController
  before_action :check_login
  before_action :check_item_permission, only: [:show_edit_page, :edit, :delete] # 只能编辑和删除自己商店内的商品
  before_action :check_store_permission, only: [:show_create_item_page, :create_item]  # 只能对自己的商店进行新建商品

  # 展示具体某个商品的详细信息
  def show
    @item = Item.find_by id: params[:item_id]
    if @item.nil?
      redirect_to '/404.html'
    end
  end

  def show_edit_page
    @item = Item.find_by(id: item_params[:item_id])
  end

  def edit
    @item = Item.find_by(id: item_params[:item_id])
    if @item.update(amount: item_params[:amount],
                    description: item_params[:description],
                    price: item_params[:price])
      redirect_to "/stores/#{@item.store_id}/items"
    else
      render :show_edit_page
    end
  end

  def delete
    item_id = item_params[:item_id]
    if not Item.destroy(item_id)
      redirect_back(fallback_location: root_url, alert: "还有尚未处理的相关订单")
    else
      redirect_back fallback_location: root_url
    end
  end

  def show_create_item_page
    @item = Item.new
  end

  def create_item
    @item = Item.new(name: item_params[:name],
                     amount: item_params[:amount],
                     price: item_params[:price],
                     store_id: item_params[:store_id],
                     description: item_params[:description])
    uploaded_io = params[:image]

    if uploaded_io.nil?
      @item.save
      render :show_create_item_page
      return
    end

    file_name = "#{(Time.new.to_f * 1000).to_i}_#{uploaded_io.original_filename}"
    File.open(Rails.root.join("app/assets/images/item_images/#{file_name}"), 'wb') do |file|
      file.write(uploaded_io.read)
    end
    @item.image_name = file_name

    if @item.save
      redirect_to "/stores/#{item_params[:store_id]}/items"
    else
      File.open(Rails.root.join("app/assets/images/item_images/#{file_name}"), 'wb') do |file|
        file.delete
      end
      render :show_create_item_page
    end
  end

  private
  def item_params
    params.permit(:item_id, :description, :amount, :store_id, :name, :price, :image)
  end

  def check_login
    redirect_to sign_in_url if session[:current_user].nil?
  end

  # 对商品进行编辑和删除操作前，需要验证该商品为当前用户的店铺内的商品
  def check_item_permission
    item = Item.find_by id: item_params[:item_id]
    redirect_to '/404.html' if item.nil? or item.store.user_id != session[:current_user]["id"]
  end

  # 新建商品前，需要验证当前上架的商店是当前用户所持有的商店
  def check_store_permission
    store = Store.find_by id: item_params[:store_id], user_id: session[:current_user]["id"]
    redirect_to '/404.html' if store.nil?
  end
end
