Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :customers, only: [:show, :create]
      resources :subscriptions, only: [:create, :update]
      resources :customer_subscriptions, only: [:show, :create]
    end
  end
end
