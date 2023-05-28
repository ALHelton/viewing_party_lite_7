class RegisterAdminController < ApplicationController
  def new
  end

  def create
    admin = Admin.create(admin_params)
    require 'pry'; binding.pry
    redirect_to "/register_admins/#{admin.id}"
  end

  def show 
    @admin = Admin.find(params[:id])
  end

  private

  def admin_params
    params.permit(:name, :email)
  end
end