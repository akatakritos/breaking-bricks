class ScraperResult < ActiveRecord::Base
  attr_accessible :availability, :availability_text, :item_id, :now_price, :scraper_run, :was_price
  belongs_to :scraper_run
  has_one :item

  def self.from_result_hash(hash)
    result = self.new
    result.item = Item.find_or_create_from_hash hash
    result.availability = hash[:availability]
    result.availability_text = hash[:availability_text]
    result.now_price = hash[:now_price]
    result.was_price = hash[:was_price]
    result
  end
end
