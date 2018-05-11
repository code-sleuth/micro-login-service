Rails.application.routes.draw do
  # devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users do
    collection do
      post 'login'
    end
  end

  post 'password/forgot', to: 'passwords#forgot'
  post 'password/reset', to: 'passwords#reset'

  resources :invites, only: [:index, :create]
end
