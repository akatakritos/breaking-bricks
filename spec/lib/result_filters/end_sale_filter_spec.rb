require 'spec_helper'

describe ResultFilters::EndSaleFilter do
  describe '#filter' do
    before do
      @last = FactoryGirl.create(:scraper_run)
    end
    describe 'when nothing changes' do
      before do
        @current = create_run_copy(@last)
        @filter = ResultFilters::EndSaleFilter.new
      end

      it 'should not yield anything' do
        expect { |b| @filter.filter @last, @current, &b }.to_not yield_control.once
      end
    end

    describe 'when a product drops off the list' do
      before do
        @current = create_run_copy(@last)
        @removed_item = @current.scraper_results.last
        @removed_item.destroy
        @current.scraper_results.reload
        @filter = ResultFilters::EndSaleFilter.new
      end

      it 'should yield once' do
        expect { |b| @filter.filter @last, @current, &b }.to yield_control.once
      end

      it 'yields the item from the previous run' do
        @filter.filter @last, @current do |l|
          l.item.should == @removed_item.item
        end
      end
    end
  end
end 
