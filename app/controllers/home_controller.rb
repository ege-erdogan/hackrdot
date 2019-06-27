class HomeController < ApplicationController
	include Scraper
	include HomeHelper
  
  def index
  	if read_from_database?
  		posts = Post.all
  		@hn_posts, @sd_posts, @reddit_posts = seperate_posts(posts)
  	else
      Post.delete_all
  		@hn_posts, @sd_posts, @reddit_posts = fetch_posts
  	end

    if logged_in?
    	@saved_posts = current_user.bookmarks.map(&:comments_url)
    end
  end

end
