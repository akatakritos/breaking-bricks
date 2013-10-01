module Tweets
  class NewSaleTweet < TweetBase
    def initialize(current)
      @current = current
    end

    def to_s
      "#{item_name(@current.item)} is now on sale for $#{@current.now_price} #{@current.item.page}"
    end
  end
end
