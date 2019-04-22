class SDPost
	include ActiveModel::Model

	attr_accessor :title, :comment_count, :sd_url, :article_url, :domain

	def initialize(title, sd_url, article_url, comments, domain)
		@title = title
		@sd_url = sd_url
		@article_url = article_url
		@comments = comments
		@domain = domain
	end
	
end