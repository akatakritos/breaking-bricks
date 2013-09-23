class Item < ActiveRecord::Base
  attr_accessible :code, :image, :name, :page

  def self.find_or_create_from_hash(hash)
    item = self.find_or_create_by_code( hash[:code] )
    item.name = hash[:name]
    item.page = hash[:page]
    item.image = hash[:image]
    item.save
    item
  end
end
