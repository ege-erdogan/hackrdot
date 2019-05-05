class HomeController < ApplicationController
	require 'benchmark'

	LIMIT = 25

  def index
  	@hn_posts = HNScraper.get_posts(LIMIT)
  	@sd_posts = SDScraper.get_posts(LIMIT)
  	@reddit_posts = RedditScraper.get_posts('programming', LIMIT)
	end

end
