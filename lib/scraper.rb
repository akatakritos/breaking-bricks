require 'open-uri'
class Scraper
  attr_accessor :url

  def initialize(options={})
    options.each do |key, value|
      self.send("#{key}=", value)
    end

  end
  
  def get_retiring_products
    page = access_retiring_products_page
    results = []

    page.search('#product-results li').each do |result|

      title_tag = result.search('h4 a').first

      if title_tag

        product_code_tag = result.search('span.item-code').first
        img_tag = result.search('a img').first
        was_price_tag = result.search('li.was-price em').first
        now_price_tag = result.search('li em').first
        availability_tag = get_availability_tag result

        results.push({ 
          :item_name => title_tag.text.strip,
          :item_code => product_code_tag.text.strip.to_i,
          :item_link => title_tag.attr('href'),
          :item_image => img_tag.attr('src'),
          :item_was_price => was_price_tag ? was_price_tag.text.match(/\d+\.\d+/) : nil,
          :item_now_price => now_price_tag.text.match(/\d+\.\d+/).to_s.to_d,
          :item_availability => availability_tag.attr('class'),
          :item_availability_text => availability_tag.text.strip
        })
      end
    end

    results
  end

  def access_retiring_products_page
    agent = Mechanize.new
    page = agent.get('http://shop.lego.com/en-US/catalog/productListing.jsp')
    form = page.form_with(:name => 'facetedNav')
    form.checkbox_with(:id => 'backAgainFlag').check
    agent.submit form
  end

  private
    def get_availability_tag (result)
       possible_tags = [  result.search('div.availability-now').first,
          result.search('div.availability-future').first,
          result.search('div.availability-questionable').first]
       possible_tags.detect { |tag| ! tag.nil? }
    end
end
