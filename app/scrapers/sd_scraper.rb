class SDScraper
	BASE_URL = "https://slashdot.org"

	def self.get_posts(page = 0)
		doc = Nokogiri::HTML(open("#{BASE_URL}/?page=#{page}"))

		raw_stories = doc.css(".story-title a")
		raw_comment_counts = doc.css(".comment-bubble")

		titles = []
		sd_urls = []

		comment_counts = raw_comment_counts.map { |c| c.inner_text }

		raw_stories.each_with_index do |story, index| 
			if !story[:onclick].nil?
				titles.push story.inner_text
				sd_urls.push "https:#{story[:href]}"
			end
		end

		posts = []
		titles.each_with_index do |title, index|
			post = SDPost.new(title,
											  sd_urls[index],
											  comment_counts[index])
			posts.push post
		end

		return posts
	end

end