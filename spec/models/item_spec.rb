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
        code = 1
        name = 'Test'
        page = '/url/'
        image = 'image.jpg'

        item = Item.find_or_create_from_hash({:code => code, :name => name, 
                                             :page => page, :image=> image})
        item.name.should == name
        item.code.should == code
        item.page.should == page
        item.image.should == image
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
        code = 1
        name = 'Test'
        page = 'url'
        image = 'img.jpg'

        item = Item.find_or_create_from_hash( :code => code, :name => name,
                                             :page => page, :image => image )

        item.name.should == name
        item.page.should == page
        item.code.should == code
        item.image.should == image
      end
    end
  end
end
