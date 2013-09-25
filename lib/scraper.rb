require 'open-uri'
class Scraper

  attr_reader :html
  def initialize(page)
    @page = page
    @html = page.to_s
  end
  
  def get_retiring_products
    results = []

    @page.search('#product-results li').each do |result|

      title_tag = result.search('h4 a').first

      if title_tag

        product_code_tag = result.search('span.item-code').first
        img_tag = result.search('a img').first
        was_price_tag = result.search('li.was-price em').first
        now_price_tag = result.search('li em').first
        availability = get_availability(result)

        results.push({ 
          :name => title_tag.text.strip,
          :code => product_code_tag.text.strip.to_i,
          :link => title_tag.attr('href'),
          :image => img_tag.attr('src'),
          :was_price => was_price_tag ? was_price_tag.text.match(/\d+\.\d+/).to_s.to_d : nil,
          :now_price => now_price_tag.text.match(/\d+\.\d+/).to_s.to_d,
          :availability => availability[:availability],
          :availability_text => availability[:availability_text]
        })
      end
    end

    results
  end


  private
    def get_availability_tag (result)
       possible_tags = [  result.search('div.availability-now').first,
          result.search('div.availability-future').first,
          result.search('div.availability-questionable').first]
       possible_tags.detect { |tag| ! tag.nil? }
    end

    def get_availability (result)
      tag = get_availability_tag(result)
      text = tag.text.strip

      sym = case text
            when 'Available Now' then :available_now
            when 'Temporarily out of stock' then :out_of_stock
            when 'Call to check product availability' then :call_to_check
            when 'Sold Out' then :sold_out
            else :unknown
      end

      { :availability => sym, :text => text }
    end

end
