# frozen_string_literal: true

Rails.application.routes.draw do
  match '/404', to: 'errors#not_found', via: :all
  match '/500', to: 'errors#internal_server_error', via: :all
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'pages#home'
  get 'dashboard', to: 'pages#dashboard'
  get 'auth/:provider/callback', to: 'sessions#create'
  delete 'sessions', to: 'sessions#destroy'

  resources :phones
  resources :users, only: %i[index edit update]
end
