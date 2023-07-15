Rails.application.routes.draw do
  get 'discover/index', to: "discover#index"
  root to: 'feed#index'
  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  resources :users do
    resources :albums, :photos, shallow:true
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
