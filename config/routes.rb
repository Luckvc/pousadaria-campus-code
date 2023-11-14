Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'

  get 'my_inn', to: 'inns#my_inn'
  resources :inns, only: [:show, :index, :new, :create, :edit, :update] do
    resources :rooms, only: [:index, :new, :create]
    collection do
      get 'search'
      get 'cities'
      get 'search_cities'
    end
  end
  
  resources :rooms, only: [:edit, :update, :show] do
    resources :custom_dates, only: [:index, :new, :create]
  end
  resources :custom_dates, only: [:index, :show]
  resources :address
end