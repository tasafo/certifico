Rails.application.routes.draw do
  resources :certificates do
    resources :subscribers, only: [:new, :create, :edit, :update]
  end

  resources :templates
  resources :issues, only: [:index, :show]

  devise_for :users

  root to: 'home#index'
end
