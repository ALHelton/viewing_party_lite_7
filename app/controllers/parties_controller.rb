class PartiesController < ApplicationController
  def new 
    @movie = MoviesFacade.individual_movie(params[:movie_id])
    @user = User.find(params[:user_id])
  end
end
