require 'spec_helper'

describe Scraper do
  describe 'parse' do
    it 'should load something' do
      scraper = Scraper.new(:url => 'spec/files/retiring-soon.html')
      products = scraper.get_retiring_products

      products.count.should > 0

      products.each do |product|
        product[:item_name].should_not be_blank
        product[:item_code].should be_kind_of(Integer)
        product[:item_link].should_not be_blank
        product[:item_image].should_not be_blank
        product[:item_now_price].should be_kind_of(BigDecimal)
        product[:item_availability].should_not be_blank
        product[:item_availability_text].should_not be_blank
      end
    end
  end
end
