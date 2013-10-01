module ResultFilters
  class PriceChangeFilter < BaseFilter
    def filter(last, current)
      current.scraper_results.each do |current_result|
        last_result = last.get_result_by_item(current_result.item)
        if last_result
          yield last_result, current_result if current_result.now_price != last_result.now_price
        end
      end
    end
  end
end
