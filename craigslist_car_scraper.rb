require 'open-uri'
require 'nokogiri'
require "uri"


  cities = ['orlando', 'tampa']
  makes   = ['honda', 'toyota', 'mini']



  #take a URL, open and parse
  def parse(page)
    document       = open(page)
    content        = document.read
    parsed_content = Nokogiri::HTML(content)


    parsed_content.css('.content').css('.result-row').first(5).each do |row|
      @title        = row.css('.hdrlnk').inner_text
      @posted_at    = row.css('time').first.attributes["datetime"].value
      @price        = row.css('.result-meta').css('.result-price').inner_text
      @neighborhood = row.css('.result-meta').css('.result-hood').inner_text
      @link         = row.css('.hdrlnk')[0].attributes.to_a[0][1].to_s

      p @title, @posted_at, @price, @neighborhood, @link
    end
  end

  cities.each { |city|
    makes.each { |make|
      url = "https://#{city}.craigslist.org/search/cta?search_distance=75&postal=32801&min_price=1000&max_price=2500&auto_make_model=#{make}&min_auto_year=2008&max_auto_year=2014&min_auto_miles=10&max_auto_miles=120000&auto_title_status=1"
      parse(url)
    }
  }


