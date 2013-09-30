module ResultFilters
  class RetiredFilter < BaseFilter
    def filter(last, current)
      last.scraper_results.each do |last_result|
        yield last_result unless current.has_item?(last_result.item)
      end
    end
  end
end
