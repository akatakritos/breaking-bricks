class ScraperPipeline

  attr_reader :run_type
  def initialize(scraper, runtype)
    @scraper = scraper
    @run_type = runtype
    @filters = FilterList.new 
  end

  def process
    products = @scraper.get_products
    current = ScraperRun.from_results(@scraper.html, products, @run_type)
    current.save

    previous = current.previous
    @filters.filter_all(previous, current) if previous
  end

  def add_filter(filter, &block)
    @filters.add(filter, block)
  end
end
