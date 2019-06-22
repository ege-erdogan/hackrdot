module BookmarksHelper

	def create_bookmark(user, bookmark)
		user.bookmarks << bookmark
	end

	def delete_bookmark(user, bookmark)
		user.bookmarks.delete bookmark
		bookmark.destroy if bookmark.users.count.zero?
	end

	def handle_bookmark(user_id, comments_url, title)
		if comments_url.include?('slashdot.org/') && !comments_url.include?('https:')
			comments_url.prepend 'https:'
		end

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
