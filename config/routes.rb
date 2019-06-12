Rails.application.routes.draw do	

  get 'users/new'
  get '/', to: 'home#index'	

end
