module ResultFilters
  class NewlyRetiring < BaseFilter
    def filter 
      @current.scraper_results.each do |current_result|
        yield current_result unless @last.has_item?(current_result.item)
      end
    end
  end
end