Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, only: [:create]
  post "/login", to: "users#login"
  post "/password_change", to: "users#password_change"
  get "/auto_login", to: "users#auto_login"
  resources :posts do
    member do
      patch 'likes'
      get 'show_likes'
      patch 'shares'
      get 'show_shares'
      get 'mypost'
      post 'find'
    end
    resources :comments
    resources :hashtags
  end
  resources :follows do
    member do
      get 'show_friends'
      get 'show_requested'
      get 'show_to_accept'
      get 'show_to_follow'
      get 'show_all'
      get 'show_relationship'
      post 'find'
    end
  end

  post 'auth/request', to:'authorization#get_authorization'
  post 'rails/active_storage/direct_uploads', to: 'direct_uploads#create'
end
