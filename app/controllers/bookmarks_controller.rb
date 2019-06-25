class BookmarksController < ApplicationController

	def show
		user_id = params[:user_id]
		site = params[:site]

		if logged_in? && current_user.id == user_id
			@bookmarks = User.find_by(id: user_id).bookmarks.reverse
			if !site.nil?
				@bookmarks.filter!{ |bookmark| bookmark.from_domain? site }
				@filter_applied = true
			end
		else
			flash[:danger] = 'Make sure you are logged in.'
			redirect_to root_path
		end
	end

	def handle
		comments_url = params[:comments_url]
		title = params[:title]
		user_id = params[:user_id]
		source = params[:source]

		if logged_in? && current_user.id == user_id
			handle_bookmark(user_id, comments_url, title)
			if source == 'bookmarks'
				redirect_to show_bookmarks_path(user_id: user_id)	
			end
		else
			flash[:danger] = 'Make sure you are logged in.'
			redirect_to root_path
		end
	end

end
