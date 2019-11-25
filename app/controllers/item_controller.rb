class ItemController < ApplicationController
  before_action :check_login

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
    file_name = "#{(Time.new.to_f * 1000).to_i}_#{uploaded_io.original_filename}"
    File.open(Rails.root.join("app/assets/images/item_images/#{file_name}"), 'wb') do |file|
      file.write(uploaded_io.read)
    end

    if @item.save
      @item.update(image_name: file_name)
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

end
