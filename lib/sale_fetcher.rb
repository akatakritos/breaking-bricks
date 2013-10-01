class SaleFetcher < FetcherBase
  def get_sale_page
    agent = Mechanize.new
    page = agent.get("http://#{domain}/en-US/Sales-And-Deals")
    form = page.form_with(:name => 'facetedNav')
    form["/com/lego/catalog/navigation/ProductListingFormHandler.resultsPerPage"] = "9999"
    page = agent.submit form
    page.parser #nokogiri document
  end
end
