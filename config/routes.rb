Rails.application.routes.draw do
  get 'types/index'
  root "leagues#index"

  resources :leagues, :countries, :types

  get "/about", to: "about#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

end
