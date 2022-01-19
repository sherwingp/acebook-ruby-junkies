Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'users/registrations' }

  devise_scope :user do
    authenticated :user do
      root 'posts#index', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "posts#index"

    get "/posts", to: "posts#index"
  
  resources :posts do
    resources :comments
  end
end
