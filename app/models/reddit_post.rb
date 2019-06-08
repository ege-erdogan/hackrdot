class RedditPost < Post	
	include ActiveModel::Model

	def initialize(title, comment_count, article_url, comments_url, domain, score)
		super
	end

end