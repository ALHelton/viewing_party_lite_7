class RegisterController < ApplicationController
  def new
    @user = User.new
  end

  def create 
    if User.exists?(email: params[:email]) == false 
      user = User.create(user_params)
      redirect_to "/users/#{user.id}"
    else 
      flash[:error] = "A user with that email address already exists. Please choose a different email."
      redirect_to "/register"
    end

  end 

  private 

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
