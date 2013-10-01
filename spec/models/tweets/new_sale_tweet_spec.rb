require 'spec_helper'

describe Tweets::NewSaleTweet  do
  let(:result) { FactoryGirl.build(:scraper_result) }
  let(:tweet) { Tweets::NewSaleTweet.new(result) }
  subject { tweet.to_s }

  it { should include(result.item.name) }
  it { should include(result.item.page) }
  it { should include(result.item.code.to_s) }
  it { should include(result.now_price) }
end

