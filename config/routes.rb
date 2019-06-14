Rails.application.routes.draw do	

  get 'sessions/new'
	root 'home#index'

	get '/signup', to: 'users#new'
	post '/signup', to: 'users#create'

	get '/login', to: 'sessions#new'
	post '/login', to: 'sessions#create'
	get '/logout', to: 'sessions#destroy'

	get '/users', to: 'users#show'

	post '/bookmark', to: 'bookmarks#create'

end
