Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get "/", to: "landing#index"

  resources :users, only: [:new, :create], controller: "register" do 
    resources :movies, only: [:index, :show], controller: 'user_movies' do 
      resources :parties, only: [:new, :create]
    end
  end
  
  get "/users/:id", to: "users#dashboard"
  get "/users/:id/discover", to: "users#discover"

  get "/dashboard", to: "dashboard#index"

  # get "/users/:user_id/movies", to: "user_movies#index"
  # get "/users/:user_id/movies/:movie_id", to: "user_movies#show"

  get "/register", to: "register#new"
  post "/register", to: "register#create"

  get "/login", to: "users#login_form"
  post "/login", to: "users#login_user"

  delete "/", to: "users#destroy"
end
