module Tweets
  class EndSaleTweet < TweetBase
    def initialize(last)
      @last = last
    end

    def to_s
      "#{item_name(@last.item)} is no longer on sale! Too bad! #{@last.item.page}"
    end
  end
end
