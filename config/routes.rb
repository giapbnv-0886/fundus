Rails.application.routes.draw do
  devise_for :dusers
  root to: "static_pages#index"
  mount RailsAdmin::Engine => "/admin", as: "rails_admin"

  get "/signup", to: "users#new"
  get "/about", to: "static_pages#about"
  get "/contact", to: "static_pages#contact"
  get "/help", to: "static_pages#help"
  get "/login", to: "sessions#new"

  post "/signup", to: "users#create"
  post "/login", to: "sessions#create"

  delete "/logout", to: "sessions#destroy"

  resources :users
end
