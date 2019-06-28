class UsersController < ApplicationController
	
	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		@user.id = SecureRandom.uuid
		if @user.save
			log_in @user
			flash[:success] = 'Account created. Welcome!'
			redirect_to root_path
		else
			render 'new'
		end
	end

	def subscribe
		user_id = params[:user_id]
		if logged_in? && current_user.id == user_id
			current_user.subscribe!
			flash[:success] = 'Thank you for subscribing to the mailing list!'
		else
			flash[:danger] = 'Make sure you are logged in.'
		end
		redirect_to root_path
	end

	private 

		def user_params
			params.require(:user).permit(:name, :email, :password, :password_confirmation, :subscribed)
		end

end
