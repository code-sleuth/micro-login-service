Rails.application.routes.draw do
  # devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users do
    collection do
      post 'login'
      post 'logout'
    end
  end

  get 'google_auth', to: redirect('/auth/google_oauth2')
  get "auth/:provider/callback", to: 'users#google_login'
  get 'auth/failure', to: redirect('/')

  post 'password/forgot', to: 'passwords#forgot'
  post 'password/reset', to: 'passwords#reset'

  root to: "users#index"

  resources :invites, only: [:index, :create]
end
