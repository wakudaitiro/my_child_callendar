Rails.application.routes.draw do

  # root to: 'visitors#index'
  get 'index', to: 'visitors#index'
  get 'statics', to: 'events#statics'
  resources :events
end
