Rails.application.routes.draw do
  get 'admin/index'
  resources :like_albums, only: [:create, :destroy]
  resources :like_photos, only: [:create, :destroy]
  get 'discover/index', to: "discover#index"
  root to: 'feed#index'
  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  resources :users do
    resources :albums, shallow:true
    resources :photos, shallow: true do
      member do
        delete "delete_for_album"
      end
    end
    member do
      patch "update_password"
    end
  end

  resources :relationships, only: [:create, :destroy]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"
  #
end
