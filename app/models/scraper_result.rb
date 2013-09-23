class ScraperResult < ActiveRecord::Base
  attr_accessible :availability, :availability_text, :item_id, :now_price, :scraper_run, :was_price
  belongs_to :scraper_run
  has_one :item
end
