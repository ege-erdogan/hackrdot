class SDPost
	include ActiveModel::Model

	attr_accessor :title, :comment_count, :sd_url, :domain, :summary, :article_url

	def initialize(title, sd_url, comment_count, domain, summary, article_url)
		@title = title
		@sd_url = sd_url
		@comment_count = comment_count
		@domain = domain
		@summary = summary
		@article_url = article_url
	end
	
end