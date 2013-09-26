class RunComparer
  def initialize(last, current)
    @last    = last
    @current = current
  end

  def newly_retiring 
    @current.scraper_results.each do |current_result|
      yield current_result unless @last.has_item?(current_result.item)
    end
  end

  def price_changes
    @current.scraper_results.each do |current_result|
      last_result = @last.get_result_by_item(current_result.item)
      if last_result
        yield last_result, current_result if current_result.now_price != last_result.now_price
      end
    end
  end

  def availability_changes
  end

  def retired
  end
end
