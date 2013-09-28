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

  def has_item?(item)
    self.scraper_results.all.each do |old_result|
      return true if old_result.item == item
    end
    
    false
  end

  def previous
    ScraperRun.where("id < ?", id).order('id DESC').first
  end

  def get_result_by_item(item)
    self.scraper_results.all.find { |r| r.item == item }
  end
end
