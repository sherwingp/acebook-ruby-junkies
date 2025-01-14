# frozen_string_literal: true

Rails.application.routes.draw do
  get 'friends/index'
  post 'friends/destroy'
  devise_for :users, controllers: { registrations: 'users/registrations', omniauth_callbacks: 'users/omniauth_callbacks' }
  
  devise_scope :user do
    authenticated :user do
      root 'profiles#new', as: :authenticated_root
    end
    
    unauthenticated do
      root 'homepage#index', as: :unauthenticated_root
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root "posts#index"
  
  get '/posts', to: 'posts#index'

  get '/users/profiles', to: 'profiles#index'
  post '/users/:user_id/profile/new', to: 'profiles#create'
  patch '/users/:user_id/profile/edit', to: 'profiles#update'


  resources :users do
    resource :notifications do
      collection do
        delete :destroy_all
      end
    end
    resource :profile
  end

  resources :posts do
    resources :comments do
      resources :likes
      resources :gemlikes
    end
  end
  
  resources :posts do
    resources :likes
    resources :gemlikes
  end

  
  resources :friend_requests
  
  resources :messages
  resources :conversations
end
