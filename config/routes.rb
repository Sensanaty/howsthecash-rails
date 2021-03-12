# frozen_string_literal: true

Rails.application.routes.draw do
  resources :users, only: %i[index create destroy]
  post '/authenticate', to: 'users#login'
end
