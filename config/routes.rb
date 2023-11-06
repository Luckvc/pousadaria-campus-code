Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'

  get 'my_inn', to: 'inns#my_inn'
  resources :inns, only: [:index, :new, :create, :edit, :update] do
    resources :rooms, only: [:index, :new, :create]
  end
  
  resources :rooms, only: [:edit, :update] do
    resources :custom_dates, only: [:index, :new, :create]
  end
  resources :custom_dates, only: [:show]
  resources :address
  
end