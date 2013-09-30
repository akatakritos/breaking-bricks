class ScraperRun < ActiveRecord::Base
  attr_accessible :html
  attr_accessible :run_type
  has_many :scraper_results

  def self.from_results(html, products, type="retiring")
    run = self.new(:html => html, :run_type => type)

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
    ScraperRun.where("run_type = ? AND id < ?", run_type, id).order('id DESC').first
  end

  def get_result_by_item(item)
    self.scraper_results.all.find { |r| r.item == item }
  end
end
