require 'spec_helper'

describe ResultFilters::PriceChange do
  describe '#filter' do
    before do
      @last = FactoryGirl.create(:scraper_run)
    end

    describe 'when the it goes on sale' do
      before do
        @current = create_run_copy(@last)
        @changed_item = @current.scraper_results.last
        @changed_item.was_price = @changed_item.now_price
        @changed_item.now_price = @changed_item.now_price - 1.00
        @filter = ResultFilters::PriceChange.new
      end

      it 'should yield once' do
        expect { |b| @filter.filter @last, @current, &b }.to yield_control.once
      end

      it 'should yield the changed_item' do
        @filter.filter @last, @current do |l,c|
          c.should == @changed_item
          l.should == @last.scraper_results.last
        end
      end
    end

    describe 'when it goes off sale' do
      before do
        @current = create_run_copy(@last)
        @changed_item = @last.scraper_results.last
        @changed_item.was_price = @changed_item.now_price
        @changed_item.now_price = @changed_item.now_price - 1.00
        @filter = ResultFilters::PriceChange.new
      end
    end

    describe 'when price simply changes' do
      before do
        @current = create_run_copy(@last)
        @changed_item = @current.scraper_results.last
        @changed_item.now_price = @changed_item.now_price-1.00
        @filter = ResultFilters::PriceChange.new
      end

      it 'should yield once' do
        expect { |b| @filter.filter @last, @current, &b }.to yield_control.once
      end

      it 'should yield the previous and current' do
        @filter.filter @last, @current do |l,c|
          l.should == @last.scraper_results.last
          c.should == @changed_item
          l.now_price.should_not == @changed_item.now_price
        end
      end
    end

    describe 'when nothing changes' do
      before do
        @current = create_run_copy(@last)
        @filter = ResultFilters::PriceChange.new
      end

      it 'should not yield anything' do
        expect { |b| @filter.filter @last, @current, &b }.to_not yield_control
      end
    end
  end
end
