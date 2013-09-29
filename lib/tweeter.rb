class Tweeter
  def initialize(twitter_config = nil)
    twitter_config = YAML.load(File.read(Rails.root.join("config", "twitter.yml"))) if twitter_config.nil?

    Twitter.configure do |config|
      config.consumer_key = twitter_config['consumer_key']
      config.consumer_secret = twitter_config['consumer_secret']
      config.oauth_token = twitter_config[Rails.env]['oauth_token']
      config.oauth_token_secret = twitter_config[Rails.env]['oauth_token_secret']
    end
  end

  def send(tweet)
    Twitter.update tweet.to_s.truncate(160)
  end
end

