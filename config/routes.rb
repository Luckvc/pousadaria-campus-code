Rails.application.routes.draw do
  devise_for :customers
  devise_for :users
  root to: 'home#index'
  get 'my_inn', to: 'inns#my_inn'

  resources :inns, only: [:show, :index, :new, :create, :edit, :update] do
    resources :rooms, only: [:index, :new, :create]
    collection do
      get 'search'
      get 'advanced_search'
      get 'advanced_search_query'
      get 'cities'
      get 'search_cities'
    end
    member do
      get 'change_status'
      get 'reviews'
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
    resources :consumables, only: [:new, :create]
    resources :additional_guests, only: [:create]
    resources :reviews, only: [:new, :create]
    collection do
      get 'inn', to: 'reservations#inn_reservations'
      get 'ongoing'
    end
    member do
      get 'check_in'
      get 'check_out'
      get 'admin'
      post 'cancelled'
      post 'admin_cancelled'
      post 'check_in_confirm'
      post 'check_out_confirm'
    end 
  end
  resources :reviews, only: [:index]  do
    post 'answer', on: :member
  end
  resources :custom_dates, only: [:index, :show]
  resources :address

  namespace :api do
    namespace :v1 do
      resources :inns, only: [:show, :index] do
        resources :rooms, only: [:index]
      end
      resources :rooms, only: [:show] do
        member do
          get 'available'
        end
      end
    end
  end
end