Rails.application.routes.draw do
  resources :users  do
  	resources :tweets
  end
  get 'tweets/all_tweets'
  root 'users#index'
end

