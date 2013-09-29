require 'spec_helper'

describe Tweets::AvailabilityChangeTweet do
  let(:result) { FactoryGirl.build(:scraper_result) }
  let(:tweet) { Tweets::AvailabilityChangeTweet.new(result, result) }
  subject { tweet.to_s }

  it { should include(result.item.name) }
  it { should include(result.item.page) }
  it { should include(result.item.code.to_s) }

  context "available_now" do
    let(:tweet) { FactoryGirl.build(:scraper_result, :availability => "available_now") }
    it 'says available again' do
      expect(Tweets::AvailabilityChangeTweet.new(result, result).to_s).to include "available again"
    end
  end

  context "out_of_stock" do
    let(:result) { FactoryGirl.build(:scraper_result, :availability => "out_of_stock") }
    it "says out of stock" do
      expect(Tweets::AvailabilityChangeTweet.new(result, result).to_s).to include "out of stock"
    end
  end

  context "call_to_check" do
    let(:result) { FactoryGirl.build(:scraper_result, :availability => "call_to_check") }
    it "says Call to check" do
      expect(Tweets::AvailabilityChangeTweet.new(result, result).to_s).to include "Call to check"
    end
  end

  context "sold_out" do
    let(:result) { FactoryGirl.build(:scraper_result, :availability => "sold_out") }
    it "says sold out" do
      expect(Tweets::AvailabilityChangeTweet.new(result, result).to_s).to include "sold out"
    end
  end

  context "unknwon" do
    let(:result) { FactoryGirl.build(:scraper_result, :availability => "unknown", :availability_text => "BUY IT NOW!!!") }
    it "has the availability_text" do
      expect(Tweets::AvailabilityChangeTweet.new(result, result).to_s).to include result.availability_text
    end
  end

end

