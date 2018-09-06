Rails.application.routes.draw do
  root to: 'top#index'

  get    'login', to: 'sessions#new'
  post   'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'
  get 'questions/:id/tags/edit', to: 'tags#edit', as: :question_tags_edit
  post 'questions/:id/tags/edit', to: 'tags#update'

  resources :users, only: [:index, :new, :show, :create]

  resources :questions, except: :destroy do
    resources :answers, only: [:new, :create]
    resources :tags, only: [:new, :create]
  end
end
