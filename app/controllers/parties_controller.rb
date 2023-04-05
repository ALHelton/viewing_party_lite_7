class PartiesController < ApplicationController
  def new
    if current_user
      @movie = MoviesFacade.new.get_all_movie_info(params[:movie_id])
      @user = User.find(params[:user_id])
      @all_users = User.all
    else
      flash[:error] = "You must be logged in or registered to create a party"
      
      if request.referrer != nil
        redirect_to request.referrer
      else
        redirect_to "/"
      end

      # @movie = MoviesFacade.new.get_all_movie_info(params[:movie_id])
      # @user = User.find(params[:user_id])
      # flash[:error] = "You must be logged in or registered to create a party"
      # redirect_to "/users/#{@user.id}/movies/#{@movie.movie_id}"
    end
  end

  def create
    @user = User.find(params[:user_id])
    @movie = MoviesFacade.new.get_all_movie_info(params[:movie_id])
    @party = Party.new(party_params)

    if @party.duration >= @movie.raw_runtime
      @party.save
      if params[:invites].present?
        params[:invites].each do |user_id|
          UserParty.create!(party_id: Party.all.last.id, user_id: user_id)
        end
      end
      redirect_to "/users/#{@user.id}"
    else
      flash[:notice] = "Duration is less than actual play time"
      redirect_to "/users/#{@user.id}/movies/#{@movie.movie_id}/parties/new"
    end
  end

  private

  def party_params
    params.permit(:name, :party_date, :party_time, :user_id, :duration, :movie_id)
  end
end
