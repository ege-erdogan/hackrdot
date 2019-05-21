class SDPost
	include ActiveModel::Model

	attr_accessor :title, :comment_count, :sd_url, :domain, :summary

	def initialize(title, sd_url, comment_count, domain, summary)
		@title = title
		@sd_url = sd_url
		@comment_count = comment_count
		@domain = domain
		@summary = summary
	end
	
end