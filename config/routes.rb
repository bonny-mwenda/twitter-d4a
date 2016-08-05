Rails.application.routes.draw do
  resources :users, only: [:show]
  resources :tweets, only: [:show, :new, :create]

  root 'users#show'
  get 'users/show'
  get 'tweets/show'
  get 'tweets/profile'
end
