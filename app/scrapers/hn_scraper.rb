class HNScraper
  require 'Nokogiri'
  require 'open-uri'

  BASE_URL = 'https://news.ycombinator.com'

  def self.get_posts(page = 1)
    doc = Nokogiri::HTML(open("#{BASE_URL}/news?page=#{page}"))

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

    def self.extract_title(row)
      return row.children[4].children[0].inner_text
    end

    def self.valid_post?(row)
      return row.children[3][:class] == 'votelinks'
    end

    def self.get_article_link(content)
      return content.children[4].children[0][:href]
    end

    def self.comment?(tag)
      return (tag.to_s.include? 'comment' or tag.to_s.include? 'discuss')
    end

    def self.extract_comment_count(text)
      return '0' if text.include?('discuss')

      return text.tr("\u00A0", ' ').split(' ')[0]
    end

    def self.form_hn_link(id)
      return "#{BASE_URL}/item?id=#{id}"
    end

end