class SDScraper
  BASE_URL = "https://slashdot.org"
  ARTICLES_PER_PAGE = 15 # sd default

  def self.get_posts(count = 15)

    page_count = (count / 15.0).ceil
    coder = HTMLEntities.new  
    posts = []

    doc = Nokogiri::HTML(open("#{BASE_URL}/archive.pl"))

    stories = doc.css('.main-content a')
    comment_details = doc.css('.cmntcnt')

    # start from 4 because first four links are unrelated
    # there is no other query possible to remove them
    stories[4..].each_with_index do |story, index|
      post = SDPost.new(coder.decode(story.inner_text),
                        story[:href],
                        comment_details[index].children[1].inner_text.split(' ')[0])
      posts.push post
      return posts if posts.length == count
    end
  end

end