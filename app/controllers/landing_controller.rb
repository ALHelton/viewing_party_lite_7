class LandingController < ApplicationController
  def index

    @admin = Admin.all
    @users = User.all
  end
end
