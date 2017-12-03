Rails.application.routes.draw do

  devise_for :users
  resources :items do
    member do
      patch 'order_item'
    end
    collection do
      get 'order_bulk' 
    end
  end

  resources :activities, only: :index

  resources :orders, only: [:show, :index, :new] do
    collection do
      get 'bulk_order'
      get 'total_amount'
      get 'order_detail'
    end
  end

  root 'items#index'

end
