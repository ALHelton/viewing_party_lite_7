class UsersController < ApplicationController
  def new 
    
  end

  def dashboard
    @user = User.find(params[:id])
    @parties = @user.matched_parties
  end

  def discover
    @user = User.find(params[:id])
  end

end