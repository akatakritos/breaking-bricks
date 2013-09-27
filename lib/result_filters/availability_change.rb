module ResultFilters
  class AvailabilityChange < BaseFilter
    def filter
      @current.scraper_results.each do |current_result|
        last_result = @last.get_result_by_item(current_result.item)
        if last_result
          yield last_result, current_result if current_result.availability_changed_from last_result
        end
      end
    end
  end
end
