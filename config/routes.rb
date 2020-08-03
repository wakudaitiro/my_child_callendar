Rails.application.routes.draw do

  root to: "homes#index"
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'
   }
  get '/users/:id', to: 'users#show', as: 'user'
  get 'calendar', to: 'events#calendar'
  resource :user, only: %i[edit] do
    collection do
      patch 'update_password'
    end
  end

  # カレンダー
  get 'statics', to: 'events#statics'
  get 'search', to: 'products#search'
  resources :events
  resources :products
end
