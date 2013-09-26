class RunComparer
  def initialize(last, current)
    @last    = last
    @current = current
  end

  def newly_retiring &block
    @current.scraper_results.each do |current_result|
      block.call current_result unless @last.has_item?(current_result.item)
    end
  end
end
