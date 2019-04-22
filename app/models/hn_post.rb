class HNPost
	include ActiveModel::Model

	attr_accessor :title, :score, :comment_count, :hn_url, :article_url

	def initialize(title, ups, comments, article_link, hn_link)
		@title = title
		@ups = ups
		@comments = comments
		@article_link = article_link
		@hn_link = hn_link
	end
	
end