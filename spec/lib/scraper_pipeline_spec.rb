require 'spec_helper'

describe ScraperPipeline do
  describe 'with new products' do
    let(:scraper) { Scraper.new }
    before do
      scraper.stub(:html => '<html></html>')
      scraper.stub(:get_retiring_products => { } )
    end

    it 'saves a new item' do
      ScraperPipeline.new(scraper).process
    end
  end
end
