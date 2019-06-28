class BookmarksController < ApplicationController

	def show
		if logged_in?
			@bookmarks = current_user.bookmarks.reverse

			site = params[:site]
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
		if logged_in?
			comments_url = params[:comments_url]
			title = params[:title]
			user_id = session[:user_id]
			source = params[:source]

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
