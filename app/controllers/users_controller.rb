class UsersController < ApplicationController
  def new 
  end

  def dashboard
    @user = User.find(params[:id])
    @invited_parties = @user.invited_parties
    @all_user_parties_host = @user.get_host_parties

    @invited_parties_with_hosts = @invited_parties.map do |party|
      movie_info = MoviesFacade.new.get_all_movie_info(party.movie_id)

      require 'pry'; binding.pry
      { party: party, 
        host: User.find_host(party.user_id), 
        movie_title: movie_info.name, 
        movie_image: "https://image.tmdb.org/t/p/w500".concat(movie_info.image),
        list_invitees: party.list_invitees }
    end
  end

  def discover
    @user = User.find(params[:id])
  end
end