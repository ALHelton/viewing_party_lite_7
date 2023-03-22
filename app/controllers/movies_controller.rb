class MoviesController < ApplicationController
  def index
    @top_rated = MovFacade.top_rated_movies
    @user = User.find(params[:user_id])
    # require 'pry'; binding.pry
  end
end