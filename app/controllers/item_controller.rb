class ItemController < ApplicationController


  # 展示具体某个商品的详细信息
  def show
    @item = Item.find_by id: params[:item_id]
    if @item.nil?
      redirect_to '/404.html'
    end
  end

  def show_edit_page
    @item = Item.find_by id: item_params[:item_id]
  end

  def edit
    @item = Item.find_by id: item_params[:item_id]
    if @item.update(amount: item_params[:amount],
                    description: item_params[:description])
      redirect_to "/stores/#{@item.id}/items"
    else
      render :show_edit_page
    end
  end

  def delete
    throw "删除商品功能尚未实现"
  end

  private
  def item_params
    params.permit(:item_id, :description, :amount)
  end

end
