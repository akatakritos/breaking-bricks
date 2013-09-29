module Tweets
  class PriceChangeTweet < TweetBase
    def initialize(last, current)
      @last = last
      @current = current
    end

    def to_s
      "BREAKING: #{@current.item.name} (#{@current.item.code}) is now on sale for $#{@current.now_price} (was $#{@current.was_price}) #{@current.item.page} #LEGO"
    end
  end
end
