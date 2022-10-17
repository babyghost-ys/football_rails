Rails.application.routes.draw do
  root to: "leagues#index"

  resources :countries, :types, :players

  resources :leagues, only: [:index, :show] do
    collection do
      get "search"
    end
  end

  get "/about", to: "about#index"

end
