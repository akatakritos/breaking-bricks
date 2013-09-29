require 'spec_helper'

describe FilterList do
  let(:filter) { double("Filter") }
  let(:block) { Proc.new { |last, current| } }

  describe '#filter_all' do
    it 'calls filter on each filter' do
      f1 = double()
      f2 = double()
      b1 = double()
      b2 = double()
      last = double()
      current = double()
      
      list = FilterList.new
      list.add(f1, b1)
      list.add(f2, b2)

      f1.should_receive(:filter).with(last, current, b1)
      f2.should_receive(:filter).with(last, current, b2)

      list.filter_all(last, current)
    end
  end

  describe FilterListElement do
    describe '#initialize' do
      it 'sets the filter and the block' do
        f = FilterListElement.new(filter, block)
        f.filter.should == filter
        f.block.should == block
      end
    end

    describe '#do_filter' do
      it 'should call filter on the filter' do
        last = double()
        current = double()
        filter.should_receive(:filter).with(last, current, block)

        f = FilterListElement.new(filter, block)
        f.do_filter(last, current)
      end
    end
  end
end


