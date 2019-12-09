Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users, controllers: { confirmations: "confirmations", omniauth_callbacks: "users/omniauth_callbacks" }
  mount RailsAdmin::Engine => "/admin", as: "rails_admin"

  root to: "static_pages#index"

  get "/login", to: "sessions#new"
  get "/about", to: "static_pages#about"
  get "/contact", to: "static_pages#contact"
  get "/search", to: "static_pages#search"
  get "/help", to: "static_pages#help"
  get "tags/:name", to: "tags#show"
  get "/cadmin", to: "cadmin/bases#index"
  get "/sign_in_with_FB", to: "facebookauth_callbacks#new"
  get "/success_facebookauth_callback", to: "facebookauth_callbacks#success"
  get "/failure_facebookauth_callback", to: "facebookauth_callbacks#failure"

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
    resource :donations, only: %i(index new create)
    resource :purchases, only: %i(new create)
    resources :events, only: %i(new index create update)
    resources :blogs, only: %i(new index create update)
    resource :amount_per_months, module: "causes", only: %i(show)
  end
  resources :users do
    resource :donation_by_months, module: "users", only: %i(show)
    resource :donation_by_weeks, module: "users", only: %i(show)
    resource :total_donation_by_months, module: "users", only: %i(show)
    resource :total_donation_by_weeks, module: "users", only: %i(show)
  end
  resources :categories
  namespace :cadmin do
    resources :users
    resources :tags
    resources :categories
    resources :causes
    resources :events
    resources :blogs
    resources :attendances
    resources :comments
  end
end
