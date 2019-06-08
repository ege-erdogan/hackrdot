class Post
	include ActiveModel::Model

	attr_accessor :title, :comment_count, :article_url, :comments_url, :domain, :score

	def initialize(title, comment_count, article_url, comments_url, domain, score)
		@title = title
		@comment_count = comment_count
		@article_url = article_url
		@comments_url = comments_url
		@domain = domain
		@score = score
	end

end
