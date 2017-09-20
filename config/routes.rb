Rails.application.routes.draw do

  devise_for :users
  resources :items do
    member do
      patch 'order_item'
    end
  end

  resources :activities, only: :index

  resources :orders, only: [:show, :index]

  root 'items#index'

end
