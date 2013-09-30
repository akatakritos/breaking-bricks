module ResultFilters
  class NewResultFilter < BaseFilter
    def filter(last, current)
      current.scraper_results.each do |current_result|
        yield current_result unless last.has_item?(current_result.item)
      end
    end
  end
end
