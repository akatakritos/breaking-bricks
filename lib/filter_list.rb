class FilterList
  def initialize()
    @list = []
  end

  def add(filter, block)
    @list << FilterListElement.new(filter, block)
  end

  def filter_all(last, current)
    @list.each do |f|
      f.do_filter(last, current)
    end
  end
end

class FilterListElement
  attr_accessor :filter, :block

  def initialize(filter, block)
    @filter = filter
    @block = block
  end

  def do_filter(last, current)
    @filter.filter(last, current, @block)
  end
end
