Rails.application.routes.draw do
	get 'users/send_message'
	resources :users  do
		resources :tweets
	end
	get 'tweets/all_tweets'
	root 'users#index'
end

