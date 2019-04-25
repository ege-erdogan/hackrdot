class HomeController < ApplicationController

  def index
  	@hn_posts = HNScraper.get_posts(25)
  	@sd_posts = SDScraper.get_posts(25)
		@reddit_posts = RedditScraper.get_posts('programming', 40)
	end

end
