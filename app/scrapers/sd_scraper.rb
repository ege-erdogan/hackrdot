class SDScraper
  BASE_URL = "https://slashdot.org"

  def self.get_posts(count = 25)
    coder = HTMLEntities.new  
    posts = []

    doc = Nokogiri::HTML(open(BASE_URL))

    headers = doc.css('.story-title a')
    comments = doc.css('.comment-bubble')
    summaries_raw = doc.css('.p')

    titles = []
    domains = []
    comment_counts = []
    sd_urls = []
    summaries = []

    headers.each do |header|
      if header[:class] == 'story-sourcelnk'
        domains.push header.inner_text
      else 
        titles.push header.inner_text
        sd_urls.push header[:href]
      end
    end

    comments.each do |comment|
      comment_counts.push comment.children[0].inner_text
    end

    summaries_raw.each do |summary|
      summaries.push summary.children.to_s
    end

    titles.each_with_index do |title, index|
      post = SDPost.new(title,
                        sd_urls[index],
                        comment_counts[index],
                        domains[index],
                        summaries[index])
      posts.push post
    end

    return posts
  end

end