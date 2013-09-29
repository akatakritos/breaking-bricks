class Fetcher
  def retiring_products_page
    agent = Mechanize.new
    page = agent.get("http://#{domain}/en-US/catalog/productListing.jsp")
    form = page.form_with(:name => 'facetedNav')
    form.checkbox_with(:id => 'backAgainFlag').check
    page = agent.submit form
    page.parser #nokogiri document
  end

  def domain
    "shop.lego.com"
  end
end
