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
    context 'of the same run_type' do
      it 'returns the previous run' do
        prev = FactoryGirl.create(:scraper_run)
        curr = FactoryGirl.create(:scraper_run)
        curr.previous.should == prev
      end
    end

    context 'when there are multiple types in the db' do
      it 'returns the previous with the same type' do
        prevA = FactoryGirl.create(:scraper_run, :run_type => "A")
        prevB = FactoryGirl.create(:scraper_run, :run_type => "B")
        curr  = FactoryGirl.create(:scraper_run, :run_type => "A")
        expect(curr.previous).to eq prevA
      end
    end
  end

  describe '#from_results' do
     context 'no type passed' do
       it 'has a retiring type' do
         run = ScraperRun.from_results("", [])
         expect(run.run_type).to eq "retiring"
       end
     end

     context "with a passed type" do
       it 'has the type' do
         run = ScraperRun.from_results("", [], "a-new-type")
         expect(run.run_type).to eq "a-new-type"
       end
     end
  end
end

