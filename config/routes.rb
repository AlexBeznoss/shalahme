# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'pages#home'
  get 'dashboard', to: 'pages#dashboard'
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'sessions', to: 'sessions#destroy'

  resources :phones
  resources :dialogs, only: %i[index new create] do
    resources :messages, only: %i[index new create]
  end
  resources :convos, only: %i[index show]
end
