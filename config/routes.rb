Rails.application.routes.draw do	

	root 'home#index'

	get '/signup', to: 'users#new'
	post '/signup', to: 'users#create'

	post '/login', to: 'sessions#create'
	get '/logout', to: 'sessions#destroy'

	get '/users', to: 'users#show'

	get '/bookmarks/handle', to: 'bookmarks#handle', as: 'handle_bookmark'
	get '/bookmarks', to: 'bookmarks#show', as: 'show_bookmarks'

	get '/about', to: 'static_pages#about'

	get '/subscribe', to: 'users#subscribe', as: 'subscribe'

end
