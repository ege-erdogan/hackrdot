class BookmarksController < ApplicationController

	def show
		user_id = params[:user_id]
		if logged_in? && current_user.id == user_id
			@bookmarks = User.find_by(id: user_id).bookmarks.reverse
		else
			# handle error
		end
	end

	def create
		comments_url = params[:comments_url]
		title = params[:title]
		user_id = params[:user_id]

		bookmark = Bookmark.find_by(comments_url: comments_url)
		if !bookmark
			comments_url.prepend 'https:' if comments_url.include? 'slashdot.org/'
			bookmark = Bookmark.new(title: title, comments_url: comments_url)
		end

		user = User.find_by(id: user_id)
		user.bookmarks << bookmark unless user.bookmarks.include? bookmark
	end

	def destroy
	end

end
