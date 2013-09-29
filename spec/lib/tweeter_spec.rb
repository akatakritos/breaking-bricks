require 'spec_helper'

describe Tweeter do
  let(:config) {
      {
        "consumer_key" => "blahblah",
        "consumer_secret" => "dsjgsdf;jog",
        "test" => {
          "oauth_token" => "jgdskghe",
          "oauth_token_secret" => "ghriufhdskjhgfd"
        }
      }
  }

  describe '#initialize' do
    it 'configures the twitter' do
      conf = double()
      Twitter.should_receive(:configure).and_yield(conf)
      conf.should_receive(:'consumer_key=').with(config["consumer_key"])
      conf.should_receive(:'consumer_secret=').with(config["consumer_secret"])
      conf.should_receive(:'oauth_token=').with(config["test"]["oauth_token"])
      conf.should_receive(:'oauth_token_secret=').with(config['test']['oauth_token_secret'])


      Tweeter.new(config)
    end
  end

  describe '#tweet' do
    let(:tweet) { double("Tweet") }
    let(:tweeter) { Tweeter.new }
    before do
      Twitter.stub(:configure).and_yield(OpenStruct.new)
      Twitter.stub(:update)
    end

    it 'calls to_s on the tweet object' do
      tweet.should_receive(:to_s).and_return("")
      tweeter.send(tweet)
    end

    it 'calls update on Twitter' do
      tweet.stub(:to_s).and_return("hello")
      Twitter.should_receive(:update).with("hello")

      tweeter.send(tweet)
    end

    it 'truncates long tweets' do
      tweet.stub(:to_s).and_return("A"*200)
      Twitter.should_receive(:update).with("A"*157 + "...")

      tweeter.send(tweet)
    end
  end
end
