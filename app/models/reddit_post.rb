class RedditPost
	include ActiveModel::Model

	attr_accessor :title, :score, :comment_count, :reddit_url, :article_url, :domain
	
	def initialize(title, comments, score, url, permalink, domain)
		@title = title
		@comment_count = comments
		@score = score
		@article_url = url
		@reddit_url = "https://reddit.com#{permalink}"
		@domain = domain
	end

end