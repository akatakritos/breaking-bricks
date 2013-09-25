require 'spec_helper'

describe ScraperResult do
  let(:item) { Item.new :code => 1, :name => 'test' }
  before do
    Item.stub(:find_or_create_from_hash) do |hash|
      Item.new :code => hash[:code], :name => hash[:name],
        :image => hash[:image], :page => hash[:page]
    end
  end

  describe 'from_result_hash' do
    it 'copies attribtues' do
      hash = create_scraper_hash
      result = ScraperResult.from_result_hash(hash)
      result.item.code.should == hash[:code]
      result.item.name.should == hash[:name]
      result.item.page.should == hash[:page]
      result.item.image.should == hash[:image]
      result.availability.should == hash[:availability]
      result.availability_text.should == hash[:availability_text]
      result.was_price.should == hash[:was_price]
      result.now_price.should == hash[:now_price]
    end
  end
end
