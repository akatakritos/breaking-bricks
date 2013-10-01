require 'spec_helper'

describe SaleFetcher do
  describe 'getting a document' do
    before do
      fetcher = SaleFetcher.new
      @page = fetcher.get_sale_page
    end
      
    it 'returns a nokogiri document' do
      @page.should be_a(Nokogiri::HTML::Document)
    end

    it 'has all the products' do
      expect(@page.search("#items").first.text.strip).to match /Items 1-(\d+) of \1/
    end
  end
end
