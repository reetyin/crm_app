Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # Add CSV format support for ActiveAdmin
  namespace :admin do
    resources :customers, only: [ :index ] do
      collection do
        get :index, format: :csv
      end
    end
    resources :admin_users, only: [ :index ] do
      collection do
        get :index, format: :csv
      end
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "customers#index"
  get "customers/alphabetized", to: "customers#alphabetized", as: "customers_alphabetized"
  get "customers/missing_email", to: "customers#missing_email", as: "customers_missing_email"
  resources :customers, only: [ :index, :show, :edit, :update ]
end
