module Tweets
  class NewlyRetiringTweet < TweetBase
    def initialize(current)
      @current = current
    end

    def to_s
      "#{item_name(@current.item)} is retiring! #{@current.item.page} #LEGO"
    end
  end
end
