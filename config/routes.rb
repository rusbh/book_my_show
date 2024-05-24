Rails.application.routes.draw do
  resources :feedbacks
  resources :shows
  resources :screens
  resources :theaters
  ActiveAdmin.routes(self)
  devise_for :users,
             path: 'auth',
             path_names: {
               sign_in: 'login',
               sign_out: 'logout',
              #  password: 'secret',
              #  confirmation: 'verification',
              #  registration: 'register',
               sign_up: 'signup'
             }
             

  root to: "home#index"
  get "up" => "rails/health#show", as: :rails_health_check
  # get '*path' => redirect('/')
end
