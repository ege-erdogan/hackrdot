class HNScraper
  require 'open-uri'

  BASE_URL = 'https://news.ycombinator.com'

  def self.get_posts(count = 25)

    coder = HTMLEntities.new
    page_count = (count / 30.0).ceil
    posts = []

    page_count.times do |page|
      doc = Nokogiri::HTML(open("#{BASE_URL}/news?page=#{page + 1}"))

      raw_articles = doc.css('.athing').to_a
      raw_scores = doc.css('span.score').to_a
      raw_comments = doc.css('td.subtext a').to_a
      raw_ids = doc.css('tr.athing').to_a

      valid_articles = raw_articles.select{ |link| valid_post? link }
                           
      titles = valid_articles.map { |post| extract_title post }
      article_urls = valid_articles.map { |article| get_article_link article }
      scores = raw_scores.map { |score| score.inner_text.split(' ')[0] }

      comment_counts = raw_comments.select{ |c| comment? c }
                                   .map { |c| extract_comment_count c.inner_text }

			hn_urls = raw_ids.map { |thing| form_hn_link thing[:id] }
      domains = article_urls.map { |url| extract_domain url  }

      count.times do |index|
        post = HNPost.new(coder.decode(titles[index]),
                          scores[index],
                          comment_counts[index],
                          article_urls[index],
                          hn_urls[index],
                          domains[index])
        posts.push post
      end
    end

    return posts
  end

  private

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
      return form_hn_link(link) if link.include? "item?id="
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