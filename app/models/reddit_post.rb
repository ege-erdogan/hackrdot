class RedditPost
	include ActiveModel::Model

	attr_accessor :title, :score, :comment_count, :reddit_url, :article_url
	
	def initialize(title, comments, score, url, permalink)
		@title = title
		@comments = comments
		@score = score
		@url = url
		@permalink = "https://reddit.com#{permalink}"
	end

end