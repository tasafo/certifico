Rails.application.routes.draw do
  resources :certificates do
    resources :subscribers, only: [:new, :create, :edit, :update]
    resources :import_subscribers, only: [:new, :create]
  end

  resources :templates
  resources :issues, only: [:index, :show]
  resources :credits, only: [:index, :new, :create]

  devise_for :users, controllers: {registrations: 'registrations'}

  root to: 'home#index'
end
