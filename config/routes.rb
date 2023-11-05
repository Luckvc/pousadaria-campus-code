Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resource :user do
    resources :inn do
      resources :room
    end
  end
  resources :address
  get 'my_inn', to: 'inn#my_inn'
end
