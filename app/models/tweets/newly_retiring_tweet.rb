module Tweets
  class NewlyRetiringTweet < TweetBase
    def initialize(current)
      @current = current
    end

    def to_s
      "#{@current.item.name} (#{@current.item.code}) is retiring! #{@current.item.page} #LEGO"
    end
  end
end
