class ScraperPipeline

  def initialize(scraper)
    @scraper = scraper
    @filters = FilterList.new 
  end

  def process
    products = @scraper.get_retiring_products
    current = ScraperRun.from_results(@scraper.html, products)
    current.save

    previous = current.previous
    @filters.filter_all(previous, current)
  end

  def add_filter(filter, &block)
    @filters.add(filter, block)
  end
end
