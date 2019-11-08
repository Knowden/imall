class SignController < ApplicationController

  def show_sign_up_page
  end

  def do_sign_up

  end

  def show_sign_in_page
  end

  def do_sign_in
    @user = User.find_by_name user_params[:name]
    if @user.nil? or @user.password != user_params[:password]
      redirect_to sign_in_url, alert: "用户名或密码错误"
    else
      session[:current_user] = @user
      redirect_to '/'
    end
  end

  def do_sign_out

  end

  private
  def user_params
    params.permit(:name, :password)
  end
end
