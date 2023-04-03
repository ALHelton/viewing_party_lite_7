class UsersController < ApplicationController
  def new 
  end

  def login_form

  end

  def login_user
    user = User.find_by(email: params[:email])

    if user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.name}"
      redirect_to "/users/#{user.id}"
    else
      flash[:error] = "Sorry, your credentials are bad."
      render :login_form
    end
  end

  def dashboard
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
  end

  def discover
    @user = User.find(params[:id])
  end
end