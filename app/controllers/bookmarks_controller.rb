class BookmarksController < ApplicationController

	def show
		user_id = params[:user_id]
		if logged_in? && current_user.id == user_id
			@bookmarks = User.find_by(id: user_id).bookmarks.reverse
		else
			flash[:danger] = 'Make sure you are logged in and using the button in the header.'
			redirect_to root_path
		end
	end

	def handle
		comments_url = params[:comments_url]
		title = params[:title]
		user_id = params[:user_id]

		if logged_in? && current_user.id == user_id
			handle_bookmark(user_id, comments_url, title)
		else
			flash[:danger] = 'Make sure you are logged in.'
			redirect_to root_path
		end
	end

end
