class BookmarksController < ApplicationController

	def show
	end

	def create
		comments_url = params[:comments_url]
		title = params[:title]
		user_id = params[:user_id]

		bookmark = Bookmark.find_by(comments_url: comments_url)
		if bookmark.nil
			bookmark = Bookmark.new(title: title, comments_url: comments_url) if bookmark.nil
		end

		user = User.find(user_id)
		user.bookmarks << bookmark unless user.bookmark.include? bookmark
	end

	def destroy
	end

end
