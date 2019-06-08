class SDPost < Post
	include ActiveModel::Model

	attr_accessor :summary

	def initialize(title, comment_count, article_url, comments_url, domain, summary)
		super(title, comment_count, article_url, comments_url, domain, 0)
		@summary = summary
	end
	
end