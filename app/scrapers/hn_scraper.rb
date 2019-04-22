class HNScraper
	require 'Nokogiri'
	require 'open-uri'

	BASE_URL = "https://news.ycombinator.com"

	def self.get_posts(page = 1)
		doc = Nokogiri::HTML(open("#{BASE_URL}/news?page=#{page}"))

		raw_articles = doc.css("a.storylink").to_a
		raw_scores = doc.css("span.score").to_a
		raw_comments = doc.css("td.subtext a").to_a
		raw_ids = doc.css("tr.athing").to_a

		titles = raw_articles.map { |article| article.inner_text }
		article_urls = raw_articles.map { |article| correct_link article[:href] }
		scores = raw_scores.map { |score| score.inner_text.split(" ")[0] }
		comment_counts = raw_comments.select{ |c| comment? c }
													 .map { |c| extract_comment_count c.inner_text }
		hn_urls = raw_ids.map { |thing| form_hn_link thing[:id] }

		posts = []
		titles.each_with_index do |title, index|
			post = HNPost.new(title, 
												scores[index], 
												comment_counts[index], 
												article_urls[index],
												hn_urls[index])
			posts.push post
		end

		return posts
	end


	private 

		def self.correct_link(link)
			if link.index("item?id") == 0
				return "#{BASE_URL}/#{link}"
			else
				return link
			end
		end

		def self.comment?(tag)
			return (tag.to_s.include? "comment" or tag.to_s.include? "discuss")
		end

		def self.extract_comment_count(text)
			if text.include? "discuss"
				return "0"
			else
				text.gsub("\u00A0", " ").split(" ")[0]
			end
		end

		def self.form_hn_link(id)
			return "#{BASE_URL}/item?id=#{id}"
		end

end