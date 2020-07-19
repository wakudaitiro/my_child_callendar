Rails.application.routes.draw do

  get 'users/show'
  root to: "homes#index"
  devise_for :users, :controllers => {
    :registrations => 'users/registrations'

   }
  get '/users/:id', to: 'users#show', as: 'user'
  resource :user, only: %i[edit] do
    collection do
      patch 'update_password'
    end
  end



  # カレンダー
  get 'index', to: 'visitors#index'
  get 'statics', to: 'events#statics'
  get 'search', to: 'products#search'
  resources :events
  resources :products
end
