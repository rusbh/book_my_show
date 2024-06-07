require 'sidekiq/web'

Rails.application.routes.draw do
  get 'profile', to: 'users#index', as: :profile
  root 'home#index'
  ActiveAdmin.routes(self)
  mount Sidekiq::Web => '/sidekiq'

  resources :shows, only: %i[index show] do
    get '/book-now', to: "screenings#index"
    resources :feedbacks, module: :shows, only: [:create, :destroy]
  end

  resources :screenings, only: [:index, :show] do
    resources :bookings, only: [:create, :new]
  end

  resources :theaters, only: %i[index show] do
    resources :feedbacks, module: :theaters, only: [:create, :destroy]
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
       
  get 'up' => 'rails/health#show', as: :rails_health_check
end
