# frozen_string_literal: true

Rails.application.routes.draw do
  get 'friends/index'
  post 'friends/destroy'
  devise_for :users, controllers: { registrations: 'users/registrations', omniauth_callbacks: 'users/omniauth_callbacks' }
  
  devise_scope :user do
    authenticated :user do
      # p "We're in the right place"
      # @user = User.find(current_user.id)
      # @user.profile.create(about:'A new profile - please update this soon!')
      # root 'post#index', as: :authenticated_root
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
    end
  end
  
  resources :posts do
    resources :likes
  end
  
  resources :friend_requests
end
