module Tweets
  class AvailabilityChangeTweet < TweetBase
  
    def initialize(last, current)
      @last = last
      @current = current
    end

    def to_s
      case @current.availability
        when "available_now" then "BREAKING: #{@current.item.name} (#{@current.item.code}) is available again! #{@current.item.page}"
        when "out_of_stock"  then "BREAKING: #{@current.item.name} (#{@current.item.code}) is out of stock! #{@current.item.page}"
        when "call_to_check" then "BREAKING: #{@current.item.name} (#{@current.item.code}) has unknown availability. Call to check! #{@current.item.page}"
        when "sold_out"      then "BREAKING: #{@current.item.name} (#{@current.item.code}) is sold out! #{@current.item.page}"
        when "unknown"       then "BREAKING: #{@current.item.name} (#{@current.item.code}) now has this availability: '#{@current.availability_text}'! #{@current.item.page}"
        else "wat: #{@current.availability}"
      end
    end
  end
end
