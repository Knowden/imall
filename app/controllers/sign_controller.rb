class SignController < ApplicationController

  def show_sign_up_page
  end

  def do_sign_up
    print user_params[:name]
  end

  def show_sign_in_page
  end

  def do_sign_in
    print user_params[:name]
  end

  def do_sign_out

  end

  private
  def user_params
    params.permit(:name, :password)
  end
end
