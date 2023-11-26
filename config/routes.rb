Rails.application.routes.draw do
  devise_for :customers
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
    member do
      get 'change_status'
      post 'activate'
      post 'deactivate'
    end
  end
  
  resources :rooms, only: [:edit, :update, :show] do
    resources :custom_dates, only: [:index, :new, :create]
    resources :pre_reservations, only: [:new, :create]
    resources :reservations, only: [:create]
  end
  resources :pre_reservations, only: [:index] do
    get 'confirmation'
  end
  resources :reservations, only: [:index, :show] do
    member do
      post 'cancelled'
    end
  end
  resources :custom_dates, only: [:index, :show]
  resources :address
end