# frozen_string_literal: true

Rails.application.routes.draw do
  resources :home, only: [:index, :show]
  post 'signup', to: 'users#create'
  get 'auth/login', to: 'authentication#new'
  post 'auth/login', to: 'authentication#authenticate'
  root 'home#index'
end
