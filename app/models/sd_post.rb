class SDPost
	include ActiveModel::Model

	attr_accessor :title, :comment_count, :sd_url

	def initialize(title, sd_url, comment_count)
		@title = title
		@sd_url = sd_url
		@comment_count = comment_count
	end
	
end