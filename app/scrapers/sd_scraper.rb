class SDScraper
  BASE_URL = "https://slashdot.org"

  def self.get_posts(count = 25)
    coder = HTMLEntities.new  
    posts = []

    doc = Nokogiri::HTML(open("#{BASE_URL}/archive.pl"))

    stories = doc.css('.main-content a')
    comment_details = doc.css('.cmntcnt')

    # start from 4 because first four links are unrelated
    # there is no other query possible to remove them
    stories[4..].each_with_index do |story, index|
      posts.push  SDPost.new(coder.decode(story.inner_text),
                             story[:href],
                             comment_details[index].children[1].inner_text.split(' ')[0])
      return posts if posts.length == count
    end
  end

end