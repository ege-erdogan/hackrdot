module Scraper
	require 'open-uri'
	include HNHelper
	include SDHelper
	include RedditHelper

	HN_URL = 'https://news.ycombinator.com/news'
	SD_URL = 'https://slashdot.org'
	REDDIT_URL = 'https://www.reddit.com/r/programming/.json'

	TYPE = {
		HN: 'HACKER_NEWS',
		REDDIT: 'REDDIT',
		SD: 'SLASHDOT'
	}

	def get_posts
		hn_posts = get_hn_posts
		sd_posts = get_sd_posts
		reddit_posts = get_reddit_posts

		posts = hn_posts + sd_posts + reddit_posts

		posts.each(&:save)
	end

	private 

		def get_hn_posts
			doc = Nokogiri::HTML(open(HN_URL))
			posts = []

			raw_articles = doc.css('.athing').to_a
      raw_scores = doc.css('span.score').to_a
      raw_comments = doc.css('td.subtext a').to_a

      valid_articles = raw_articles.select(&method(:valid_post?))

      titles = valid_articles.map(&method(:extract_title))
      article_urls = valid_articles.map(&method(:get_article_link))
      scores = raw_scores.map { |score| score.inner_text.split(' ')[0] }

      comments = raw_comments.select(&method(:comment?))
      comment_counts = comments.map(&:inner_text)
      												 .map(&method(:extract_comment_count))
      hn_urls = comments.map { |c| form_hn_link c[:href]  }

      domains = article_urls.map(&method(:extract_domain))

      titles.each_with_index do |title, index|
      	post = Post.new
      	post.title = title
      	post.article_url = article_urls[index]
      	post.comments_url = comment_urls[index]
      	post.domain = domains[index]
      	post.score = scores[index]
      	post.comment_count = comment_counts[index]
      	post.type = TYPE[:HN]

      	posts.push post
      end

      return posts
		end

		def get_sd_posts
			doc = Nokogiri::HTML(open(SD_URL))
			posts = []

			headers = doc.css('.story-title a')
	    comments = doc.css('.comment-bubble')
	    summaries_raw = doc.css('.p')

	    titles = []
	    domains = []
	    comment_counts = []
	    sd_urls = []
	    summaries = [] 
	    article_urls = []

	    last = :domain
	    headers.each do |header|
	      if header[:class] == 'story-sourcelnk'
	        domains.push header.inner_text
	        article_urls.push header[:href]
	        last = :domain
	      else 
	        if last == :title
	          domains.push(' ')
	          article_urls.push(' ')
	        end
	        titles.push header.inner_text
	        sd_urls.push header[:href]
	        last = :title
	      end
	    end

	    comments.each do |comment|
	      comment_counts.push comment.children[0].inner_text
	    end

	    while comment_counts.length < 15
	      comment_counts.prepend 0
	    end

	    summaries_raw.each do |summary|
	      html = summary.children.to_s
	      if html[-12..-1].include? '<br>'
	        html = html[0...-12]
	      end
	      summaries.push html
	    end

	    titles.each_with_index do |title, index|
				post = SDPost.new(title,
													comment_counts[index],
													article_urls[index],
													sd_urls[index],
	                        domains[index],
	                        summaries[index])

				post = Post.new
				post.title = title
				post.comment_count = comment_counts[index]
				post.article_url = article_urls[index]
				post.comments_url = sd_urls[index]
				post.domain = domains[index]
				post.summary = summaries[index]
				post.type = TYPE[:SD]
	      
	      posts.push post
	    end

	    return posts
		end

		def get_reddit_posts
			doc = HTTParty.get(REDDIT_URL, headers: { 'User-Agent' => 'hackrdot' })
			coder = HTMLEntities.new
			posts = []

			content = JSON.parse json.to_s, symbolize_names: true 

      25.times do |i|
        data = content[:data][:children][i][:data]

        post = Post.new
        post.title = coder.decode(data[:title])
        post.comment_count = data[:num_comments]
        post.article_url = data[:url]
        post.comments_url = "https://reddit.com#{data[:permalink]}"
        post.domain = data[:domain]
        post.score = data[:ups]
        post.type = TYPE[:REDDIT]

        posts.push post
      end

      return posts
		end

end