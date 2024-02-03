class ApplicationController < ActionController::Base
  helper_method :current_user, :require_login

  def require_login 
    unless current_user
      flash[:error] = "You must be logged in"
      redirect_to "/"
    end
  end

  def current_user
    @current_user = User.find(session[:user_id]) if session[:user_id]
  end

end
