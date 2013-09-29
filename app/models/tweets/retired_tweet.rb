module Tweets
  class RetiredTweet < TweetBase

    def initialize(last)
      @last = last
    end

    def to_s
      "BREAKING: #{@last.item.name} (#{@last.item.code}) has retired! Sad day. #{@last.item.page}"
    end
  end
end

