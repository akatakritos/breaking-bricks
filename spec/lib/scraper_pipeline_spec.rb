require 'spec_helper'

describe ScraperPipeline do
  describe 'with new products' do
    let(:scraper) { Scraper.new }
    before do
      scraper.stub(:html => '<html></html>')
      scraper.stub(:get_retiring_products => { } )
    end

  end
end
