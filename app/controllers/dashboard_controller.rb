class DashboardController < ApplicationController
  def index
    if !current_user
      flash[:error] = "You must log in to access dashboard"
      redirect_to "/"
    end
  end
end