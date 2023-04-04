class DashboardController < ApplicationController
  def index
    if current_user
      @user = User.find(params[:id])
      @invited_parties = @user.invited_parties
      @all_user_parties_host = @user.get_host_parties.map do |party|
        movie_info = MoviesFacade.new.get_all_movie_info(party.movie_id)

        { party: party, 
          host: User.find_host(party.user_id), 
          movie_title: movie_info.name, 
          movie_image: "https://image.tmdb.org/t/p/w500".concat(movie_info.image),
          list_invitees: party.list_invitees }
      end

      @invited_parties_with_hosts = @invited_parties.map do |party|
        movie_info = MoviesFacade.new.get_all_movie_info(party.movie_id)

        { party: party, 
          host: User.find_host(party.user_id), 
          movie_title: movie_info.name, 
          movie_image: "https://image.tmdb.org/t/p/w500".concat(movie_info.image),
          list_invitees: party.list_invitees }
      end
    else
      flash[:error] = "You must log in to access dashboard"
      redirect_to "/"
    end
  end
end