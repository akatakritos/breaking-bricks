require 'spec_helper'

describe Scraper do
  describe 'parse' do
    before do
      scraper = Scraper.new(Nokogiri::HTML(open('spec/files/retiring-soon.html')))
      @products = scraper.get_retiring_products
    end

    it 'should load something' do
      @products.count.should == 16
      @products.each do |product|
        product[:name].should_not be_blank
        product[:code].should be_kind_of(Integer)
        product[:link].should_not be_blank
        product[:image].should_not be_blank
        product[:now_price].should be_kind_of(BigDecimal)
        product[:availability].should_not be_blank
        product[:availability_text].should_not be_blank
      end
    end

    it 'should have all the product codes' do
      product_codes = [3937, 9679, 9476, 9678, 3183, 3848, 3856, 3939, 41017, 5695, 5794, 70113, 71000, 8065, 9469, 9489]
      product_codes.each do |code|
        @products.detect { |prod| prod[:code] == code }.should_not be_nil
      end
    end

    describe 'the standard block' do
      it 'should have a now_price but no was_price' do
        prod = @products.find { |prod| prod[:code] == 3937 }
        prod[:code].should == 3937
        prod[:now_price].should == 9.99
        prod[:was_price].should be_nil
        prod[:availability_text].should == 'Available Now'
      end
    end

    describe 'a sale price block' do
      it 'should have a now_price and a was_price' do
        prod = @products.find { |p| p[:code] == 8065 }
        prod[:now_price].should == 8.98
        prod[:was_price].should == 10.99
      end
    end

    describe 'an out of stock item' do
      it 'should have an availability and an availability text' do
        prod = @products.find { |p| p[:code] == 9476 }
        prod[:availability].should == 'out_of_stock'
        prod[:availability_text].should == "Temporarily out of stock"
      end
    end

    describe 'call to check stock item' do
      it 'should have an availability of :call_to_check and a text' do
        prod = @products.find { |p| p[:code] == 9678 }
        prod[:availability].should == 'call_to_check'
        prod[:availability_text].should == 'Call to check product availability'
      end
    end

    describe 'a sold out product' do
      it 'should have availability :sold_out and a text' do
        prod = @products.find { |p| p[:code] == 3183 }
        prod[:availability].should == 'sold_out'
        prod[:availability_text].should == "Sold Out"
      end
    end
  end
end
