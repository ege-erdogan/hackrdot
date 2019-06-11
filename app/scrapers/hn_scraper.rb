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

  def self.extract_domain(url)
    head = url.index('/') + 2
    head += 4 if url.include?('www')
    url = url[head..]
    tail = url.index('/')
    return url[0...tail]
  end

  def self.extract_title(row)
    return row.children[4].children[0].inner_text
  end

  def self.valid_post?(row)
    return row.children[3][:class] == 'votelinks'
  end

  def self.get_article_link(content)
    link = content.children[4].children[0][:href]
    return form_hn_link(link) if link.include? 'item?id='

    return link
  end

  def self.comment?(tag)
    return (tag.to_s.include? 'comment' or tag.to_s.include? 'discuss')
  end

  def self.extract_comment_count(text)
    return '0' if text.include?('discuss')

    return text.tr("\u00A0", ' ').split(' ')[0]
  end

  def self.form_hn_link(id)
    return "#{BASE_URL}/item?id=#{id}" unless id.include? 'item?id'

    return "#{BASE_URL}/#{id}"
  end

end