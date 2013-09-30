namespace :scraper do
  desc "Runs the scraper in the current environment"
  task :run => :environment do
    fetcher = Fetcher.new
    scraper = Scraper.new fetcher.retiring_products_page, fetcher.domain
    pipeline = ScraperPipeline.new(scraper)

    tweeter = Tweeter.new

    pipeline.add_filter(ResultFilters::NewlyRetiringFilter.new) do |result|
      tweet = Tweets::NewlyRetiringTweet.new(result)
      tweeter.send_tweet(tweet)
    end

    pipeline.add_filter(ResultFilters::PriceChangeFilter.new) do |old, new|
      tweeter.send_tweet(Tweets::PriceChangeTweet.new(old, new))
    end

    pipeline.add_filter(ResultFilters::AvailabilityChangeFilter.new) do |old, new|
      tweeter.send_tweet(Tweets::AvailabilityChangeTweet.new(old,new))
    end

    pipeline.add_filter(ResultFilters::RetiredFilter.new) do |old|
      tweeter.send_tweet(Tweets::RetiredTweet.new(old))
    end

    pipeline.process
  end

end
