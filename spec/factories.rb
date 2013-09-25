module Factories
  def create_scraper_hash(overrides = {})
    hash = { :code => 1, :name => 'item', :page => 'item.html',
             :image => 'item.jpg', :availability => :available,
             :availability_text => "available now", :was_price => 9.99,
             :now_price => 7.99 }
    hash.merge(overrides);
  end
end
