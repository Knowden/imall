class ItemController < ApplicationController


  # 展示具体某个商品的详细信息
  def show
    @item = Item.find_by id: params[:item_id]
    if @item.nil?
      redirect_to '/404.html'
    end
  end


end
