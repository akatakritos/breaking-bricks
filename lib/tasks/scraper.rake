namespace :scraper do
  desc "Runs the scraper in the current environment"
  task :run => :environment do
    fetcher = Fetcher.new
    scraper = Scraper.new fetcher.retiring_products_page
    pipeline = ScraperPipeline.new(scraper)

    tweeter = Tweeter.new

    pipeline.add_filter(ResultFilters::NewlyRetiring.new) do |result|
      tweet = Tweets::NewlyRetiringTweet.new(result)
      tweeter.send_tweet(tweet)
    end

    pipeline.process
  end

end
