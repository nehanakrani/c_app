Rails.application.routes.draw do
  devise_for :users

  get 'user/:id', to: 'users#show', as: 'user'

  resources :rooms do
    resources :messages
  end

  root 'pages#index'
end
