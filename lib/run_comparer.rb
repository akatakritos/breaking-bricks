class RunComparer
  def initialize(last, current)
    @last    = last
    @current = current
  end

  def newly_retiring &block
    @current.scraper_results.each do |current_result|
      if ! @last.has_item?(current_result.item)
        block.call(current_result)
      end
    end
  end
end
