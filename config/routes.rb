# frozen_string_literal: true

Rails.application.routes.draw do
  resources :home, only: :index
  post 'signup', to: 'users#create'
  get 'auth/login', to: 'authentication#new'
  post 'auth/login', to: 'authentication#authenticate'
  post '/test', to: 'home#index'
  get '/test', to: 'home#index'
  root 'home#index'
end
