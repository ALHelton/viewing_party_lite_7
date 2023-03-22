class MoviesController < ApplicationController
  def index
    @user = User.find(params[:user_id])

    @top_rated = if params[:keywords].present?
      MovFacade.keywords(params[:keywords])
    else
      MovFacade.top_rated_movies
    end
  end
end