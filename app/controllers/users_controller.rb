class UsersController < ApplicationController

	def show
		@user = User.find(params[:id])
	end	

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

	private 

		def user_params
			params.require(:user).permit(:name, :email, :password, :password_confirmation)
		end

end
