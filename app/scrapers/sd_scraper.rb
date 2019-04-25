class SDScraper
  BASE_URL = "https://slashdot.org"
  ARTICLES_PER_PAGE = 15 # sd default

  def self.get_posts(count = 15)

    page_count = (count / 15.0).ceil
    coder = HTMLEntities.new  
    posts = []

    page_count.times do |page|
      doc = Nokogiri::HTML(open("#{BASE_URL}/?page=#{page}"))

      raw_stories = doc.css('.story-title a')
      raw_comment_counts = doc.css('.comment-bubble')
      raw_article_links = doc.css('.story-sourcelnk')

      titles = []
      sd_urls = []

      article_urls = raw_article_links.map { |a| a[:href] }
      domains = raw_article_links.map(&:inner_text)
      comment_counts = raw_comment_counts.map(&:inner_text)

      raw_stories.each do |story|
        unless story[:onclick].nil?
          titles.push story.inner_text
          sd_urls.push "https:#{story[:href]}"
        end
      end

      ARTICLES_PER_PAGE.times do |index|
        post = SDPost.new(coder.decode(titles[index]),
                          sd_urls[index],
                          comment_counts[index],
                          article_urls[index],
                          domains[index])
        posts.push post
        break if posts.length == count
      end
    end

    return posts
  end

end