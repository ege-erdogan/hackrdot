class HomeController < ApplicationController

  def index
  	@hn_posts = HNScraper.get_posts(10)
  	@sd_posts = SDScraper.get_posts(10)
		@reddit_posts = RedditScraper.get_posts('programming', 10)
	end

end
