class HomeController < ApplicationController
	require 'benchmark'

	LIMIT = 25

  def index
  	puts "Hacker News: "
  	puts Benchmark.measure { 
  		@hn_posts = HNScraper.get_posts(LIMIT)
  	}
  	puts "Slashdot: "
  	puts Benchmark.measure {
  		@sd_posts = SDScraper.get_posts(LIMIT)
  	}
  	puts "Reddit: "
		puts Benchmark.measure {
			@reddit_posts = RedditScraper.get_posts('programming', LIMIT)
		}
	end

end
