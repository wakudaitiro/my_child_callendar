Rails.application.routes.draw do

  # root to: 'visitors#index'
  get 'index', to: 'visitors#index'
  get 'statics', to: 'events#statics'
  # get 'products', to: 'products#index'
  get 'search', to: 'products#search'
  resources :events
  resources :products
end
