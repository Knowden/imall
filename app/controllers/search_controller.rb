class SearchController < ApplicationController
  before_action :check_login

  def show_search_page
    if search_params[:key_word].nil? or search_params[:key_word] == ""
      redirect_to root_url
    end
    @items = Item.where("name like ?", "%#{search_params[:key_word]}%")
  end

  private
  def search_params
    params.permit(:key_word)
  end

  def check_login
    redirect_to sign_in_url if session[:current_user].nil?
  end
end
