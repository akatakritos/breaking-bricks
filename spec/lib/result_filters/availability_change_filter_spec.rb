require 'spec_helper'

describe ResultFilters::AvailabilityChange do

  describe '#filter' do
    before do
      @last = FactoryGirl.create(:scraper_run)
    end
    describe 'no change in availability' do
      before do
        @current = create_run_copy(@last)
        @filter = ResultFilters::AvailabilityChange.new
      end

      it 'should not yield' do
        expect { |b| @filter.filter(@last, @current, &b) }.to_not yield_control
      end
    end

    describe 'when the availability is different' do
      before do
        @current = create_run_copy(@last)
        @changed_result = @current.scraper_results.last
        @changed_result.availability = "DIFFERENT"
        @filter = ResultFilters::AvailabilityChange.new
      end

      it 'should yield once' do
        expect { |b| @filter.filter(@last, @current, &b) }.to yield_control.once
      end

      it 'should yield the current and last results' do
        @filter.filter(@last, @current) do |l, c|
          l.should == @last.scraper_results.last
          c.should == @changed_result
          l.availability.should_not == c.availability
        end
      end
    end

    describe 'when the availability_text is different' do
      before do
        @current = create_run_copy(@last)
        @changed_result = @current.scraper_results.last
        @changed_result.availability_text = "DIFFERENT"
        @filter = ResultFilters::AvailabilityChange.new
      end

      it 'should yield once' do
        expect { |b| @filter.filter(@last, @current, &b) }.to yield_control.once
      end

      it 'should yield the current and last results' do
        @filter.filter(@last, @current) do |l, c|
          l.should == @last.scraper_results.last
          c.should == @changed_result
          l.availability_text.should_not == c.availability_text
        end
      end
    end
  end
end
