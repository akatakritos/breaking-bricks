require 'spec_helper'

describe Tweets::RetiredTweet do
  let(:result) { FactoryGirl.build(:scraper_result) }
  let(:tweet) { Tweets::RetiredTweet.new(result) }
  subject { tweet.to_s }

  it { should include(result.item.name) }
  it { should include(result.item.page) }
  it { should include(result.item.code.to_s) }
end

