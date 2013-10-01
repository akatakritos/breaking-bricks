module Tweets
  class TweetBase
    def item_name(item)
      "#{item.name} (#{item.code})"
    end
  end
end
