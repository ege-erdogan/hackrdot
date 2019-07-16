class HomeController < ApplicationController
	include Scraper
	include HomeHelper
  
  def index
    raise 'PostLoadingException' if Post.count.zero?

    posts = Post.all
    @hn_posts, @sd_posts, @reddit_posts = seperate_posts(posts)

  	@saved_posts = current_user.bookmarks.map(&:comments_url) if logged_in?
  end

end
