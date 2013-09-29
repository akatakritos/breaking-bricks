require 'rubygems'
require 'twitter'
require 'oauth'

namespace :twitter do
  desc "Gets the OAUTH Token and secret for configuring the twitter client"
  task :oauth => :environment do

    # http://blog.andrewcantino.com/blog/2011/05/12/how-to-make-your-rails-app-tweet-the-twitter/
    twitter_config = YAML.load(File.read(Rails.root.join("config", "twitter.yml")))
    consumer_key = twitter_config['consumer_key']
    consumer_secret = twitter_config['consumer_secret']

    oauth_consumer = OAuth::Consumer.new(consumer_key, consumer_secret,
                                         :site => 'http://api.twitter.com',
                                         :request_endpoint => 'http://api.twitter.com',
                                         :sign_in => true)
    request_token = oauth_consumer.get_request_token
    rtoken = request_token.token
    rsecret = request_token.secret

    puts "Now visit the following URL: "
    puts request_token.authorize_url

    print "What was the PIN twitter provided you with? "
    pin = STDIN.gets.chomp

      OAuth::RequestToken.new(oauth_consumer, rtoken, rsecret)
      access_token = request_token.get_access_token(:oauth_verifier => pin)
      puts "oath_token: " + access_token.token
      puts "oauth_token_secret: " + access_token.secret

      Twitter.configure do |config|
        config.consumer_key = consumer_key
        config.consumer_secret = consumer_secret
        config.oauth_token = access_token.token
        config.oauth_token_secret = access_token.secret
      end

      Twitter::Client.new.verify_credentials
      
  end

  desc 'Test the settings'
  task :verify => :environment do
    Tweeter.new
    Twitter::Client.new.verify_credentials
    p "Connection Successful!"
  end

end
