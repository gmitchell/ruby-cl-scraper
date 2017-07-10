require 'open-uri'
require 'nokogiri'

cities      = ['orlando', 'newyork', 'dallas']
searchTerms = ['ruby', 'java', 'javascript']

cities.each do |city|
  searchTerms.each do |term|

    url = "https://#{city}.craigslist.org/search/cpg?query=#{term}&is_paid=all"

    document = open(url)
    content = document.read
    parsed_content = Nokogiri::HTML(content)

    puts "===================================================================="
    puts "-                                                                  -"
    puts "-                     #{city} - #{term}"
    puts "-                                                                  -"
    puts "===================================================================="

    parsed_content.css('.content').css('.result-row').each do |row|
    title        = row.css('.hdrlnk').inner_text
    link         = row.css('.hdrlnk').first.attributes["href"].value
    posted_at    = row.css('time').first.attributes["datetime"].value
    neighbor_ele = row.css('.result-meta').css('.result-hood')

    if neighbor_ele.any?
      neighborhood = neighbor_ele.inner_text.strip
      else
      neighborhood = ''
    end

    puts "#{title}  #{neighborhood}"
    puts "Posted at #{posted_at}"
    puts link
    puts '-----------------------------------------------------------------'
    end
  end
end
    
