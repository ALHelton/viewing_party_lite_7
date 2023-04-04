class RegisterController < ApplicationController
  def new
    @user = User.new
  end

  def create 
    user = user_params
    user[:email] = user[:email].downcase
    @user = User.new(user)

    if params[:password] == params[:password_confirmation] && @user.save
      session[:user_id] = @user.id
      redirect_to "/users/#{@user.id}"
    else
      flash[:error] = "Can't create - make sure email is new and passwords match, and all required fields filled in"
      redirect_to "/register"
    end
  end 

  private 

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
