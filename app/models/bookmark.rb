class Bookmark < ApplicationRecord

	has_and_belongs_to_many :users

	def type
		if self.comments_url.include? 'news.ycombinator.com/'
			return :hn_post
		elsif self.comments_url.include? 'reddit.com/r/programming'
			return :reddit_post
		else
			return :sd_post
		end
	end

end
