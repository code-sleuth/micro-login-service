Rails.application.routes.draw do
  resources :users do
    collection do
      post 'login'
      get 'generate_access_token'
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
