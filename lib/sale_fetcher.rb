class SaleFetcher < FetcherBase
  def get_sale_page
    agent = Mechanize.new
    page = agent.get("http://#{domain}/en-US/Sales-And-Deals")
    page = agent.click(page.link_with(:text => "View All"))
    page.parser #nokogiri document
  end
end
