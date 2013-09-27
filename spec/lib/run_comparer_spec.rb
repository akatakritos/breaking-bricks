require 'spec_helper'
describe RunComparer do
  describe '#newly_retiring' do
    before do
      @last = FactoryGirl.create(:scraper_run)
    end

    describe 'when one appears on the list' do
      before do
        @current = create_run_copy(@last)
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
        @current = create_run_copy(@last)

        @comparer = RunComparer.new(@last, @current)
      end

      it 'should not yeld' do
        expect { |b| @comparer.newly_retiring &b }.to_not yield_control
      end
    end
  end

  describe '#price_changes' do
    before do
      @last = FactoryGirl.create(:scraper_run)
    end

    describe 'when the it goes on sale' do
      before do
        @current = create_run_copy(@last)
        @changed_item = @current.scraper_results.last
        @changed_item.was_price = @changed_item.now_price
        @changed_item.now_price = @changed_item.now_price - 1.00
        @comparer = RunComparer.new(@last, @current)
      end

      it 'should yield once' do
        expect { |b| @comparer.price_changes &b }.to yield_control.once
      end

      it 'should yield the changed_item' do
        @comparer.price_changes do |l,c|
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
        @comparer = RunComparer.new(@last, @current)
      end
    end

    describe 'when price simply changes' do
      before do
        @current = create_run_copy(@last)
        @changed_item = @current.scraper_results.last
        @changed_item.now_price = @changed_item.now_price-1.00
        @comparer = RunComparer.new(@last, @current)
      end

      it 'should yield once' do
        expect { |b| @comparer.price_changes &b }.to yield_control.once
      end

      it 'should yield the previous and current' do
        @comparer.price_changes do |l,c|
          l.should == @last.scraper_results.last
          c.should == @changed_item
          l.now_price.should_not == @changed_item.now_price
        end
      end
    end

    describe 'when nothing changes' do
      before do
        @current = create_run_copy(@last)
        @comparer = RunComparer.new(@last, @current)
      end

      it 'should not yield anything' do
        expect { |b| @comparer.price_changes &b }.to_not yield_control
      end
    end
  end

  describe '#availability_changes' do
    before do
      @last = FactoryGirl.create(:scraper_run)
    end
    describe 'no change in availability' do
      before do
        @current = create_run_copy(@last)
        @comparer = RunComparer.new(@last, @current)
      end

      it 'should not yield' do
        expect { |b| @comparer.availability_changes &b }.to_not yield_control
      end
    end

    describe 'when the availability is different' do
      before do
        @current = create_run_copy(@last)
        @changed_result = @current.scraper_results.last
        @changed_result.availability = "DIFFERENT"
        @comparer = RunComparer.new(@last, @current)
      end

      it 'should yield once' do
        expect { |b| @comparer.availability_changes &b }.to yield_control.once
      end

      it 'should yield the current and last results' do
        @comparer.availability_changes do |l, c|
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
        @comparer = RunComparer.new(@last, @current)
      end

      it 'should yield once' do
        expect { |b| @comparer.availability_changes &b }.to yield_control.once
      end

      it 'should yield the current and last results' do
        @comparer.availability_changes do |l, c|
          l.should == @last.scraper_results.last
          c.should == @changed_result
          l.availability_text.should_not == c.availability_text
        end
      end
    end
  end

  describe '#retired' do
    before do
      @last = FactoryGirl.create(:scraper_run)
    end
    describe 'when nothing changes' do
      before do
        @current = create_run_copy(@last)
        @comparer = RunComparer.new(@last, @current)
      end

      it 'should not yield anything' do
        expect { |b| @comparer.retired &b }.to_not yield_control.once
      end
    end

    describe 'when a product drops off the list' do
      before do
        @current = create_run_copy(@last)
        @removed_item = @current.scraper_results.last
        @removed_item.destroy
        @current.scraper_results.reload
        @comparer = RunComparer.new(@last, @current)
      end

      it 'should yield once' do
        expect { |b| @comparer.retired &b }.to yield_control.once
      end

      it 'yields the item from the previous run' do
        @comparer.retired do |l|
          l.item.should == @removed_item.item
        end
      end
    end
  end
end
