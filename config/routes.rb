Rails.application.routes.draw do

  # root to: 'visitors#index'
  get 'index', to: 'visitors#index'
  resources :events
end
