class RedditPost
	include ActiveModel::Model

	attr_accessor :title, :score, :comment_count, :reddit_url, :article_url
	
	def initialize(title, comments, score, url, permalink)
		@title = title
		@comment_count = comments
		@score = score
		@article_url = url
		@reddit_url = "https://reddit.com#{permalink}"
	end

end