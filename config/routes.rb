Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  get "up" => "rails/health#show", as: :rails_health_check
  root to: "home#index"
end
