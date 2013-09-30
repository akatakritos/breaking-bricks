require 'spec_helper'

describe SaleFetcher do
  describe 'getting a document' do
    it 'returns a nokogiri document' do
      fetcher = SaleFetcher.new
      page = fetcher.get_sale_page
      page.should be_a(Nokogiri::HTML::Document)
    end
  end
end
