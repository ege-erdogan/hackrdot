class RedditScraper
  require 'benchmark'
  BASE_URL = 'https://www.reddit.com/r'
  ARTICLES_PER_PAGE = 25 # reddit default

  def self.get_posts(subreddit = 'programming', count = 25)

    page_count = (count / ARTICLES_PER_PAGE.to_f).ceil

    json = HTTParty.get("#{BASE_URL}/#{subreddit}/.json?count=#{count}",
                        headers: {'User-Agent' => 'news-app'})

    coder = HTMLEntities.new

    posts = []

    page_count.times do |page|
      content = JSON.parse json.to_s, symbolize_names: true 
      after = content[:data][:after]

      ARTICLES_PER_PAGE.times do |i|
        data = content[:data][:children][i][:data]
        post = RedditPost.new(coder.decode(data[:title]),
                              data[:num_comments],
                              data[:ups],
                              data[:url],
                              data[:permalink],
                              data[:domain])
        posts.push post
        return posts if posts.length == count
      end

      json = HTTParty.get("#{BASE_URL}/#{subreddit}/.json?count=#{count}&after=#{after}",
                        headers: {'User-Agent' => 'news-app'})
    end

    return posts
  end

end