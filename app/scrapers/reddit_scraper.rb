class RedditScraper
  require 'HTTParty'
  require 'JSON'
  require 'open-uri'

  BASE_URL = 'https://www.reddit.com/r'

  def self.get_posts(subreddit, count)
    json = HTTParty.get("#{BASE_URL}/#{subreddit}/.json?count=#{count}",
                        headers: {'User-Agent' => 'news-app'})
    content = JSON.parse json.to_s, symbolize_names: true

    posts = []
    (0...count).each do |i|
      data = content[:data][:children][i][:data]
      post = RedditPost.new(data[:title],
                            data[:num_comments],
                            data[:ups],
                            data[:url],
                            data[:permalink])
      posts.push post
    end

    return posts
  end

end