Rails.application.routes.draw do
  devise_for :users, controllers: { confirmations: "confirmations", omniauth_callbacks: "users/omniauth_callbacks" }
  mount RailsAdmin::Engine => "/admin", as: "rails_admin"

  root to: "static_pages#index"

  get "/login", to: "sessions#new"
  get "/about", to: "static_pages#about"
  get "/contact", to: "static_pages#contact"

  resources :users, only: %i(index show)
  resources :comments
  resources :attendances, only: %i(create destroy)
  resources :blogs do
    resources :comments
  end
  resources :events do
    resources :attendances, only: %i(index create destroy)
  end
  resources :causes do
    resources :donations, only: %i(index)
  end
  resources :causes
  resources :causes do
    resource :donations, only: %i(new create)
    resource :purchases, only: %i(new create)
  end
  resources :categories


end
