require 'spec_helper'

describe ScraperRun do
  describe '#has_item?' do
    describe 'when it does have an item' do
      it 'should return true' do
        run = FactoryGirl.create(:scraper_run)
        run.has_item?(run.scraper_results.last.item).should be_true
      end
    end

    describe 'when it does not have the item' do
      it 'should return false' do
        run = FactoryGirl.create(:scraper_run)
        run.has_item?(FactoryGirl.create(:item)).should be_false
      end
    end
  end

  describe '#previous' do
    it 'returns the previous run' do
      prev = FactoryGirl.create(:scraper_run)
      curr = FactoryGirl.create(:scraper_run)
      curr.previous.should == prev
    end
  end
end

