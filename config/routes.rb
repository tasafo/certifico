require 'sidekiq/web'

Rails.application.routes.draw do
  root to: 'home#index'

  resources :certificates do
    resources :subscribers
    resources :import_subscribers, only: %i[new create]
    resource :send_by_email, only: %i[create]
  end

  resources :templates
  resources :issues, only: %i[index update destroy]
  resources :validates, only: %i[new create show]
  resources :usernames, only: %i[new update]

  devise_for :users, controllers: { registrations: 'registrations' }

  namespace :admin do
    authenticate :user, lambda { |user| user.admin? } do
      mount Sidekiq::Web => '/sidekiq'
    end
  end
end
