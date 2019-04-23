class HomeController < ApplicationController

  def index
  	@hn_posts = HNScraper.get_posts
  	@sd_posts = SDScraper.get_posts
		@reddit_posts = RedditScraper.get_posts('programming', 20)
  end

end
