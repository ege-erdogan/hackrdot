module HomeHelper 

	def seperate_posts(posts)
		# seperate the posts into three groups
		# w.r.t to their 'type' field
		# return all three lists at once
		hn_posts = []
		sd_posts = []
		reddit_posts = []
		posts.each do |post|
			case post.type
			when 'HACKER_NEWS'
				hn_posts.push post
			when 'SLASHDOT'
				sd_posts.push post
			when 'REDDIT'
				reddit_posts.push post
			end
		end

		return hn_posts, sd_posts, reddit_posts
	end

	def read_from_database?
		# check the 'created_at' date of the first post
		# if it is less than the threshold return true
		# otherwise return false
		post = Post.first

		return false if post.nil?

		creation_time = Post.created_at
		now = Time.now

		return now - creation_time > 600 # 10 minutes
		
	end

end