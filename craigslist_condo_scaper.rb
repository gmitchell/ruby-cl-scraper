require 'open-uri'
require 'nokogiri'

cities      = ['orlando', 'miami', 'tampa']
searchTerms = ['condo', 'townhouse']

cities.each do |city|
  searchTerms.each do |term|

    url = "https://#{city}.craigslist.org/search/apa?query=#{term}&postedToday=1&min_price=900&max_price=1500&min_bedrooms=2&availabilityMode=0&pets_dog=1"

    document = open(url)
    content = document.read
    parsed_content = Nokogiri::HTML(content)

    puts "\n===================================================================="
    puts "-                                                                  -"
    puts "-                     #{city} - #{term}"
    puts "-                                                                  -"
    puts "===================================================================="

    parsed_content.css('.content').css('.result-row').each do |row|
    title        = row.css('.hdrlnk').inner_text
    link         = row.css('.hdrlnk').first.attributes["href"].value
    posted_at    = row.css('time').first.attributes["datetime"].value
    price        = row.css('.result-meta').css('.result-price').inner_text
    neighborhood = row.css('.result-meta').css('.result-hood').inner_text

    puts "Title: #{title} - #{neighborhood}"
    puts "Price: #{price}"
    puts "Posted at #{posted_at}"
    puts link
    puts "\n"
    puts "-----------------------------------------------------------------\n"
    puts "\n"
    end
  end
end
    
