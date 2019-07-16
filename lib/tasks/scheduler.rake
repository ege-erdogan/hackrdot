desc 'This task automatically fetches posts from HN, Reddit, and Slashdot'
task :fetch_posts => :environment do 
  include Scraper

  puts 'STARTED Fetching posts...'
  Scraper.fetch_posts
  puts 'DONE - Fetched posts.'
end