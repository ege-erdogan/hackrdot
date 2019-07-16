module HomeHelper 

	def seperate_posts(posts)
		hn_posts = []
		sd_posts = []
		reddit_posts = []
		posts.each do |post|
			case post.site
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

end