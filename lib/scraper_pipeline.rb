class ScraperPipeline
  def initialize(scraper)
    @scraper = scraper
  end

  def process
    products = @scraper.get_retiring_products
    run = ScraperRun.from_results(@scraper.html, products)
    run.save
  end
end
