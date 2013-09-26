require 'spec_helper'
describe RunComparer do
  describe '#newly_retiring' do
    before do
      @last = FactoryGirl.create(:scraper_run)
    end

    describe 'when one appears on the list' do
      before do
        @current = FactoryGirl.create(:scraper_run)
        (0...@last.scraper_results.length).each do |i|
          @current.scraper_results[i].item = @last.scraper_results[i].item
        end
        @new_result = FactoryGirl.create(:scraper_result)
        @current.scraper_results << @new_result
        @comparer = RunComparer.new(@last, @current)
      end

      it 'should yield once' do
        expect { |b| @comparer.newly_retiring &b }.to yield_control.once
      end

      it 'should yield the new result' do
        @comparer.newly_retiring do |result|
          result.should == @new_result
        end
      end
    end

    describe 'when theyre all the same' do
      before do
        @current = FactoryGirl.create(:scraper_run)
        (0...@last.scraper_results.length).each do |i|
          @current.scraper_results[i].item = @last.scraper_results[i].item
        end

        @comparer = RunComparer.new(@last, @current)
      end

      it 'should not yeld' do
        expect { |b| @comparer.newly_retiring &b }.to_not yield_control
      end
    end
  end
end
