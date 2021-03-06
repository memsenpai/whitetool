Rails.application.routes.draw do
  root "users#index"
  devise_for :users
  # Api definition
  namespace :api do
    namespace :v1 do
      resources :users
      resources :sessions
    end
  end
  resources :users
end
