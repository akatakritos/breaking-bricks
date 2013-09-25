require 'spec_helper'

describe Fetcher do
  describe 'getting a document' do
    it 'returns a nokogiri document' do
      fetcher = Fetcher.new
      page = fetcher.retiring_products_page
      puts page.class
      page.should be_a(Nokogiri::HTML::Document)
    end
  end
end
