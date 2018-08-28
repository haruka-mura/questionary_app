Rails.application.routes.draw do
  root to: 'top#index'

  get    'login', to: 'sessions#new'
  post   'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'

  resources :users, only: [:index, :new, :show, :create]
  resources :questions, except: :destroy
end
