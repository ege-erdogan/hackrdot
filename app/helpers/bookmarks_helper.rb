module BookmarksHelper

	def create_bookmark(user, bookmark)
		user.bookmarks << bookmark
	end

	def delete_bookmark(user, bookmark)
		user.bookmarks.where(comments_url: bookmark.comments_url).destroy_all
	end

	def handle_bookmark(user_id, comments_url, title)
		comments_url.prepend 'https:' if comments_url.include? 'slashdot.org/'

		bookmark = Bookmark.find_by(comments_url: comments_url)
		if bookmark.nil?
			bookmark = Bookmark.new(title: title, comments_url: comments_url)
		end

		user = User.find_by(id: user_id)

		if user.bookmarks.include? bookmark
			delete_bookmark(user, bookmark)
		else
			create_bookmark(user, bookmark)
		end
	end

end
