Rails.application.routes.draw do
  get 'profile', to: 'users#index', as: :profile
  root 'home#index'
  ActiveAdmin.routes(self)

  namespace :admin do
    root 'screens#index'
    resources :screens do
      resources :shows
    end
  end

  devise_for :users,
             path: 'auth',
             path_names: {
               sign_in: 'login',
               sign_out: 'logout',
               sign_up: 'signup'
             }

  resources :feedbacks
  resources :shows, only: %i[index show]
  resources :theaters, only: %i[index show]
  # resources :screens

  get 'up' => 'rails/health#show', as: :rails_health_check

  # devise_scope :user do
  #   authenticated :user do
  #     root "home#index"
  #   end

  #   unauthenticated do
  #     root "home#index", as: :unauthenticated_root
  #   end
  # end

  # authenticate :user, ->(u) { u.admin? } do
  #   root 'dashboard#index'
  # end

  # get '/admin', to: redirect('/admin/:theater_id')
  # get '*path' => redirect('/')
end
