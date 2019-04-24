class HNPost
	include ActiveModel::Model

	attr_accessor :title, :score, :comment_count, :hn_url, :article_url, :domain

	def initialize(title, score, comment_count, article_link, hn_link, domain)
		@title = title
		@score = score
		@comment_count = comment_count
		@article_url = article_link
		@hn_url = hn_link
		@domain = domain
	end
	
end