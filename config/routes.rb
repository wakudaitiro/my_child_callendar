Rails.application.routes.draw do

  get 'products/index'
  get 'products/search'
  # root to: 'visitors#index'
  get 'index', to: 'visitors#index'
  get 'statics', to: 'events#statics'
  get 'products', to: 'products#index'
  get 'products', to: 'products#search'
  resources :events
end
