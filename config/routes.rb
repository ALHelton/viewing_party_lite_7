Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get "/", to: "landing#index"

  resources :users, only: [:new, :create] 
  
  get "/users/:id", to: "users#dashboard"
  get "/users/:id/discover", to: "users#discover"

  get "/register", to: "register#new"
  post "/register", to: "register#create"
end
