class ScraperRun < ActiveRecord::Base
  attr_accessible :html
  has_many :scraper_results

  def self.from_results(html, products)
    run = self.new(:html => html)

    products.each do |project|
      run_result = ScraperResult.from_result_hash(project)
      run.scraper_results.push(run_result)
    end

    run.save
    run
  end
end
