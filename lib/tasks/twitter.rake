require 'rubygems'
require 'twitter'
require 'oauth'

namespace :twitter do
  desc "Gets the OAUTH Token and secret for configuring the twitter client"
  task :oauth => :environment do
    consumer_key = "hll2YzL9xDK4M0h93yBrA"
    consumer_secret = "9CQ3fgbhEUgZndvMtj0ZEW7TrzRb2kfc5Ea4znzuNc"

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
    puts pin

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
end
