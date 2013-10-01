namespace :scraper do
  desc "Runs the scraper in the current environment"
  task :retiring => :environment do
    fetcher = Fetcher.new
    scraper = Scraper.new fetcher.retiring_products_page, fetcher.domain
    pipeline = ScraperPipeline.new(scraper, "retiring")

    tweeter = Tweeter.new

    pipeline.add_filter(ResultFilters::NewlyRetiringFilter.new) do |result|
      tweeter.send_tweet(Tweets::NewlyRetiringTweet.new(result))
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

  desc "Runs the Sales Scraper"
  task :sale => :environment do
    fetcher = SaleFetcher.new
    scraper = Scraper.new fetcher.get_sale_page, fetcher.domain
    pipeline = ScraperPipeline.new(scraper, "sales")

    tweeter = Tweeter.new

    pipeline.add_filter(ResultFilters::NewSaleFilter.new) do |new|
      tweeter.send_tweet(Tweets::NewSaleTweet.new(new))
    end

    pipeline.add_filter(ResultFilters::PriceChangeFilter.new) do |old, new|
      tweeter.send_tweet(Tweets::PriceChangeTweet.new(old,new))
    end

    pipeline.add_filter(ResultFilters::AvailabilityChangeFilter.new) do |old, new|
      tweeter.send_tweet(Tweets::AvailabilityChangeTweet.new(old,new))
    end

    pipeline.add_filter(ResultFilters::EndSaleFilter.new) do |old|
      tweeter.send_tweet(Tweets::EndSaleTweet.new(old))
    end

    pipeline.process
  end
end
