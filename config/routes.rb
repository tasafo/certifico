require 'sidekiq/web'

Rails.application.routes.draw do
  root to: 'home#index'

  resources :certificates do
    resources :subscribers
    resources :import_subscribers, only: [:new, :create]
  end

  resources :templates
  resources :issues, only: [:index, :update]
  resources :validates, only: [:new, :create, :show]
  resources :usernames, only: [:new, :update]

  devise_for :users, controllers: {registrations: 'registrations'}

  namespace :admin do
    authenticate :user, lambda { |user| user.admin? } do
      mount Sidekiq::Web => '/sidekiq'
    end
  end
end
