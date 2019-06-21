class SessionsController < ApplicationController

  def new

  end

  def create
  	user = User.find_by(email: params[:session][:email].downcase)
  	if user && user.authenticate(params[:session][:password])
  		log_in user
  		remember user
  	else 
  		flash[:danger] = "Invalid email/password combination!"
  	end
    redirect_to root_path
  end

  def destroy
  	log_out if logged_in?
  	redirect_to root_path
  end

end
