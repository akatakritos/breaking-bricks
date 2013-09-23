require 'spec_helper'

describe Scraper do
  describe 'parse' do
    it 'should load something' do
      scraper = Scraper.new(:url => 'spec/files/retiring-soon.html')
      products = scraper.get_retiring_products

      products.count.should > 0

      products.each do |product|
        product[:name].should_not be_blank
        product[:code].should be_kind_of(Integer)
        product[:link].should_not be_blank
        product[:image].should_not be_blank
        product[:now_price].should be_kind_of(BigDecimal)
        product[:availability].should_not be_blank
        product[:availability_text].should_not be_blank
      end
    end
  end
end
