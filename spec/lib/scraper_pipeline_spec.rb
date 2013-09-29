require 'spec_helper'

describe ScraperPipeline do
  describe 'process' do
    it 'calls filter on all the filters' do
    
        scraper = double("Scraper")
        scraper.stub(:get_retiring_products).and_return(nil)
        scraper.stub(:html).and_return(nil)
        run1 = FactoryGirl.create(:scraper_run)
        run2 = FactoryGirl.create(:scraper_run)
        run2.stub(:previous).and_return run1

        ScraperRun.should_receive(:from_results).with(scraper.html, scraper.get_retiring_products).and_return(run2)
        ScraperRun.stub(:from_results).and_return run2
        
        pipeline = ScraperPipeline.new(scraper)
        filter1 = double()
        block1 = Proc.new { |l,c| }
        filter2 = double()
        block2 = Proc.new { |l,c| }

        pipeline.add_filter filter1, &block1
        pipeline.add_filter filter2, &block2

        filter1.should_receive(:filter).with(run1, run2, &block1)
        filter2.should_receive(:filter).with(run1, run2, &block2)

        pipeline.process
    end
  end
end

