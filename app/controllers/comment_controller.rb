class CommentController < ApplicationController
  before_action :check_login
  before_action :check_permission

  def show_create_comment_page
    @comment = Comment.new
  end

  def create_comment
    order = Order.find_by id: params[:order_id]
    @comment = Comment.new(content: comment_params[:content],
                           item_id: order.item[:id],
                           user_id: session[:current_user]["id"],
                           create_date: Date.today)
    if @comment.save
      order.update(order_state_id: 3)
      redirect_to orders_url
    else
      render :show_create_comment_page
    end
  end

  private
  def comment_params
    params.permit(:order_id, :content)
  end

  def check_login
    redirect_to sign_in_url if session[:current_user].nil?
  end

  # 只有存在对应的未评论的商品时，才有权限进行评论
  def check_permission
    order = Order.find_by id: comment_params[:order_id],
                           user_id: session[:current_user]["id"],
                           order_state_id: 2
    redirect_to '/404.html' if order.nil?
  end
end
