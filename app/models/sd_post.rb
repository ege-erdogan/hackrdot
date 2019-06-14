class SDPost < Post
	include ActiveModel::Model

	attr_accessor :summary

	def initialize(title, comment_count, article_url, comments_url, domain, summary)
		@title = title
		@comment_count = comment_count
		@article_url = article_url
		@comments_url = comments_url
		@domain = domain
		@score = 0
		@summary = summary
	end

	
end