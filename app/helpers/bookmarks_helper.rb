module BookmarksHelper

	def create_bookmark(bookmark)
		current_user.bookmarks << bookmark
	end

	def delete_bookmark(bookmark)
		current_user.bookmarks.delete bookmark
		bookmark.destroy if bookmark.users.count.zero?
	end

	def handle_bookmark(comments_url, title)
		if comments_url.include?('slashdot.org/') && !comments_url.include?('https:')
			comments_url.prepend 'https:'
		end

		bookmark = Bookmark.find_by(comments_url: comments_url)
		if bookmark.nil?
			bookmark = Bookmark.new(title: title, comments_url: comments_url)
		end

		if current_user.bookmarks.include? bookmark
			delete_bookmark(bookmark)
		else
			create_bookmark(bookmark)
		end
	end

end
