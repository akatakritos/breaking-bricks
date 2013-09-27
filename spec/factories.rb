module Factories
  def create_scraper_hash(overrides = {})
    hash = { :code => 1, :name => 'item', :page => 'item.html',
             :image => 'item.jpg', :availability => :available,
             :availability_text => "available now", :was_price => 9.99,
             :now_price => 7.99 }
    hash.merge(overrides);
  end

  def create_run_copy(last_run)
    run = FactoryGirl.create(:scraper_run)
    (0...last_run.scraper_results.length).each do |i|
      run.scraper_results[i].item = last_run.scraper_results[i].item
      run.scraper_results[i].was_price = last_run.scraper_results[i].was_price
      run.scraper_results[i].now_price = last_run.scraper_results[i].now_price
      run.scraper_results[i].availability = last_run.scraper_results[i].availability
      run.scraper_results[i].availability_text = last_run.scraper_results[i].availability_text
      run.scraper_results[i].save!
    end

    run
  end
end

FactoryGirl.define do
  factory :item do
    sequence(:name)  { |n| "Item #{n}" }
    sequence(:code)  { |n| n }
    sequence(:image) { |n| "image-#{n}.jpg" }
    sequence(:page)  { |n| "item-#{n}.html" }
  end

  factory :scraper_result do
    availability "available"
    availability_text "Now Available"
    now_price 9.99

    item
  end

  factory :scraper_run do
    sequence(:html) { |n| "<html>#{n}</html>" }

    after_create do |run|
      FactoryGirl.create_list(:scraper_result, 3, :scraper_run => run)
    end
  end
end

