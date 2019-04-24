class SDPost
	include ActiveModel::Model

	attr_accessor :title, :comment_count, :sd_url, :article_url, :domain

	def initialize(title, sd_url, comment_count, article_url, domain)
		@title = title
		@sd_url = sd_url
		@comment_count = comment_count
		@article_url = article_url
		@domain = domain
	end
	
end