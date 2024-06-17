require 'sidekiq/web'

Rails.application.routes.draw do
  get 'profile', to: 'users#index', as: :profile
  root 'home#index'
  ActiveAdmin.routes(self)
  mount Sidekiq::Web => '/sidekiq'

  resources :shows, only: %i[index show] do
    get '/book-now', to: 'screenings#index'
    resources :feedbacks, only: %i[create update destroy edit]
  end

  resources :screenings, only: [:index] do
    resources :bookings, only: %i[create new]
  end

  resources :theaters, only: %i[index show] do
    resources :feedbacks, only: %i[create update destroy edit]
  end

  namespace :admin do
    root 'screens#index'
    resources :screens do
      resources :screenings
    end
  end

  devise_for :users,
             path: 'auth',
             path_names: {
               sign_in: 'login',
               sign_out: 'logout',
               sign_up: 'signup'
             }

  get '/theater-inquiry', to: 'users#theater_inquiry'
  post '/theater-inquiry', to: 'users#theater_inquiry_details'
  get 'up' => 'rails/health#show', as: :rails_health_check
  match '*path', via: :all, to: 'application#not_found_method', constraints: lambda { |req|
    req.path.exclude? 'rails/active_storage'
  }
end
