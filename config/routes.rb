Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get "/", to: "landing#index"

  resources :users, only: [:new, :create] do
    resources :movies, only: [:index, :show], controller: "user_movies" do
      resources :parties, only: [:new, :create, :destroy]
    end
  end

  get "/users/:id", to: "users#dashboard"
  get "/users/:id/discover", to: "users#discover"
  post "/session", to: "sessions#create"
  delete "/session", to: "sessions#delete"
  get "/register_admins/:id", to: "register_admin#show"

  # get "/users/:user_id/movies", to: "user_movies#index"
  # get "/users/:user_id/movies/:movie_id", to: "user_movies#show"

  get "/register", to: "register#new"
  post "/register", to: "register#create"
  get "/register_admin", to: "register_admin#new"
  post "/register_admin", to: "register_admin#create"
  get "/register_admin/:id", to: "register_admin#dashboard"

  delete "/parties/:party_id", to: "parties#destroy"

end
