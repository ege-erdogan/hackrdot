class HNScraper
  require 'open-uri'

  BASE_URL = 'https://news.ycombinator.com'

  def self.get_posts(count = 25)
    page_count = (count / 30.0).ceil
    posts = []

    page_count.times do |page|
      doc = Nokogiri::HTML(open("#{BASE_URL}/news?page=#{page + 1}"), nil, Encoding::UTF_8.to_s)

      raw_articles = doc.css('.athing').to_a
      raw_scores = doc.css('span.score').to_a
      raw_comments = doc.css('td.subtext a').to_a

      valid_articles = raw_articles.select(&method(:valid_post?))

      titles = valid_articles.map(&method(:extract_title))
      article_urls = valid_articles.map(&method(:get_article_link))
      scores = raw_scores.map { |score| score.inner_text.split(' ')[0] }

      comments = raw_comments.select(&method(:comment?))
      comment_counts = comments.map { |c| extract_comment_count c.inner_text }
      hn_urls = comments.map { |c| form_hn_link c[:href]  }

      domains = article_urls.map(&method(:extract_domain))

      count.times do |index|
				post = HNPost.new(titles[index],
													comment_counts[index],
													article_urls[index],
													hn_urls[index],
													domains[index],
													scores[index])
    posts.push post
      end
    end

    return posts
  end

end