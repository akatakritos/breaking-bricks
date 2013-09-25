require 'spec_helper'

describe ScraperRun do
  describe '#from_results' do 
    before do
      ScraperResult.stub(:from_result_hash) do |hash|
        result = ScraperResult.new
        result.code = hash[:code]
        result
      end

      ScraperRun.any_instance.stub(:save) { true }
    end

    it 'stores the html' do
      html = "<html></html>"
      run = ScraperRun.from_results(html, [])
      run.html.should == html
    end
  end

  it 'creates a set of ScraperResults' do
    results = [
      create_scraper_hash( :code => 1),
      create_scraper_hash( :code => 2)
    ]

    run = ScraperRun.from_results(nil, results)
    run.scraper_results.length.should == results.length
  end
end

