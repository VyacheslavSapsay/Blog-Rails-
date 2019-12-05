Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  root 'posts#index'



  resources :posts do
    resources :comments do
      resources :votes
      post '/dislikes' => 'votes#dislike', as: :dislike_create
    end
  end

  resources :authors
  resources :sessions, only: [:new, :create, :destroy]
  get 'signup', to: 'authors#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
