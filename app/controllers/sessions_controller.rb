class SessionsController < ApplicationController
  
  def create
    @user = User.find_by(email: params[:email])
    if @user && @user.email == params[:email]
      session[:user_id] = @user.id
      redirect_to "/", notice: "Logged in!"
    else
      render "new"
    end
  end

  def delete 
    session[:user_id] = nil
    redirect_to "/", notice: "Logged out!"
  end
end