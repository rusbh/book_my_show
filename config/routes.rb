require "sidekiq/web"

Rails.application.routes.draw do
  root "home#index"

  devise_for :users,
             path: "/",
             path_names: {
               sign_in: "login",
               sign_out: "logout",
               sign_up: "signup"
             }

  ActiveAdmin.routes(self)
  mount Sidekiq::Web => "/sidekiq"

  namespace :admin do
    root "screens#index"
    resources :screens do
      resources :screenings
      post "switch_theater", on: :collection, as: :switch_theater
    end
  end

  resources :shows, only: %i[index show] do
    get "/book-now", to: "screenings#index"
    resources :feedbacks, only: %i[create update destroy edit]
    member do
      get :languages
    end
  end

  resources :screenings, only: [ :index ] do
    resources :bookings, only: %i[create new] do
      member do
        patch :cancel_booking
      end
    end
  end

  resources :theaters, only: %i[index show] do
    resources :feedbacks, only: %i[create update destroy edit]
    resources :event_requests, only: %i[create new]
  end

  get "search", to: "search#index", as: :search
  get "profile", to: "users#index", as: :profile

  get "/admin-requests", to: "admin_requests#new"
  post "/admin-requests", to: "admin_requests#create"
  get "up" => "rails/health#show", as: :rails_health_check

  match "*path", via: :all, to: "application#not_found_method", constraints: lambda { |req|
    req.path.exclude? "rails/active_storage"
  }
end
