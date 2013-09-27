require 'spec_helper'

describe ResultFilters::NewlyRetiring do
  describe '#filter' do
    before do
      @last = FactoryGirl.create(:scraper_run)
    end

    describe 'when one appears on the list' do
      before do
        @current = create_run_copy(@last)
        @new_result = FactoryGirl.create(:scraper_result)
        @current.scraper_results << @new_result
        @filter = ResultFilters::NewlyRetiring.new(@last, @current)
      end

      it 'should yield once' do
        expect { |b| @filter.filter &b }.to yield_control.once
      end

      it 'should yield the new result' do
        @filter.filter do |result|
          result.should == @new_result
        end
      end
    end

    describe 'when theyre all the same' do
      before do
        @current = create_run_copy(@last)

        @filter = ResultFilters::NewlyRetiring.new(@last, @current)
      end

      it 'should not yeld' do
        expect { |b| @filter.filter &b }.to_not yield_control
      end
    end
  end
end

