class ScraperRun < ActiveRecord::Base
  attr_accessible :html
  has_many :scraper_results
end
