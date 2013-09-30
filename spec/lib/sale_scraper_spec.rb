require 'spec_helper'

describe SaleScraper do
  describe 'parse' do

    let(:products) do
      scraper = SaleScraper.new(Nokogiri::HTML(open('spec/files/sales.html')), "example.com")
      scraper.get_products
    end

    def get_product(code)
      products.detect { |p| p[:code] == code }
    end
      

    it 'should load something' do
      products.count.should == 33
      products.each do |product|
        product[:name].should_not be_blank
        product[:code].should be_kind_of(Integer)
        product[:page].should_not be_blank
        product[:image].should_not be_blank
        product[:now_price].should be_kind_of(BigDecimal)
        product[:availability].should_not be_blank
        product[:availability_text].should_not be_blank
        expect(product[:page]).to match /http:\/\/.*$/
      end
    end

    it 'should have all the product codes' do
      product_codes = [21201, 41020, 41021, 41022, 5001351, 70100,
                       70101, 70102, 70104, 70105, 70106, 850443,
                       850449, 850451, 850487, 850506, 850598,
                       850611, 850612, 850614, 850674, 850775,
                       850776, 850777, 853393, 853403, 853412, 9679,
                       3920, 70103, 850514, 850615, 9678]
      product_codes.each do |code|
        get_product(code).should_not be_nil
      end
    end

    it 'passes some spot checks' do
      expect(get_product(21201)[:was_price]).to eq 29.99
      expect(get_product(21201)[:now_price]).to eq 19.48

      expect(get_product(70105)[:name]).to eq "Nest Dive"

      expect(get_product(9678)[:availability]).to eq "call_to_check"
    end


    it 'has a now_price and was_price for each' do
      products.each do |p|
        expect(p[:was_price]).to be_a(BigDecimal)
        expect(p[:now_price]).to be_a(BigDecimal)
      end
    end

    it 'has a different now_prie and was_price for each' do
      products.each do |p|
        expect(p[:was_price]).to be > p[:now_price]
      end
    end
  end
end
