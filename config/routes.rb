# frozen_string_literal: true

Rails.application.routes.draw do
  get 'friends/index'
  devise_for :users, controllers: { registrations: 'users/registrations' }

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

  resources :users do
    resource :profile
  end

  resources :posts do
    resources :comments
  end

  resources :posts do
    resources :likes
  end
end
