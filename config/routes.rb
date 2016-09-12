#require 'sidekiq/web'

Rails.application.routes.draw do
  resources :certificates do
    resources :subscribers, only: [:new, :create, :edit, :update]
    resources :import_subscribers, only: [:new, :create]
  end

  resources :templates
  resources :issues, only: [:index, :show]
  resources :credits, only: [:index, :new, :create, :show]

  devise_for :users, controllers: {registrations: 'registrations'}

  namespace :admin do
    resources :notifications, only: [:create]
    #mount Sidekiq::Web, at: '/sidekiq'
  end

  root to: 'home#index'
end
