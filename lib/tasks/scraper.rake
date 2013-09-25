namespace :scraper do
  desc "Runs the scraper in the current environment"
  task :run => :environment do
    fetcher = Fetcher.new
    scraper = Scraper.new fetcher.retiring_products_page
    pipeline = ScraperPipeline.new(scraper)
    pipeline.process
  end

end
