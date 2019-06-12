class HomeController < ApplicationController

	LIMIT = 25
  
  def index
    @hn_posts = HNScraper.get_posts(LIMIT)
    @sd_posts = SDScraper.get_posts
    @reddit_posts = RedditScraper.get_posts('programming', LIMIT)
  end

end
