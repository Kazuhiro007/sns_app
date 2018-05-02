Rails.application.routes.draw do
  get 'favorites/index'
  root 'pages#index'

  get 'pages/help'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  resources :users do
    member do
      get :following, :followers
    end
  end
  resources 'topics'
  resources 'comments'
  post '/favorites', to: 'favorites#create'
  resources :relationships,       only: [:create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end