class SDScraper
  BASE_URL = "https://slashdot.org"

  def self.get_posts(count = 15)

    page_count = (count / 15.0).ceil
    coder = HTMLEntities.new  
    posts = []

    page_count.times do |page|
      doc = Nokogiri::HTML(open("#{BASE_URL}/?page=#{page}"))

      raw_stories = doc.css('.story-title a')
      raw_comment_counts = doc.css('.comment-bubble')

      titles = []
      sd_urls = []

      comment_counts = raw_comment_counts.map(&:inner_text)

      raw_stories.each do |story|
        unless story[:onclick].nil?
          titles.push story.inner_text
          sd_urls.push "https:#{story[:href]}"
        end
      end

      count.times do |index|
        post = SDPost.new(coder.decode(titles[index]),
                          sd_urls[index],
                          comment_counts[index])
        posts.push post
      end
    end

    return posts
  end

end