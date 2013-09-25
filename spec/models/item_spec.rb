require 'spec_helper'

describe Item do
  describe '#find_or_create_from_hash' do
    before do
      Item.any_instance.stub(:save).and_return(true)
    end

    describe 'creating a new one' do
      before do
        Item.stub(:find_or_create_by_code) do |code|
          Item.new :code => code
        end
      end

      it 'should create a new one with the right hash' do
        hash = create_scraper_hash
        item = Item.find_or_create_from_hash(hash)
        item.name.should  == hash[:name]
        item.code.should  == hash[:code]
        item.page.should  == hash[:page]
        item.image.should == hash[:image]
      end
    end

    describe 'finding an existing one' do
      before do
        Item.stub(:find_or_create_by_code) do |code|
          Item.new :code => code, :id => 1, :name => 'x', :page => 'y',
            :image => 'z'
        end
      end

      it 'should update the attribtues' do

        hash = create_scraper_hash
        item = Item.find_or_create_from_hash(hash)

        item.name.should  == hash[:name]
        item.page.should  == hash[:page]
        item.code.should  == hash[:code]
        item.image.should == hash[:image]
      end
    end
  end
end
