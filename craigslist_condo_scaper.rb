require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'open-uri'
require 'nokogiri'
require_relative 'listingclass'


@cities = ['orlando', 'miami', 'tampa']
@searchTerms = ['condo', 'townhouse']

@cities.each do |city|
  @searchTerms.each do |term|
    @base_url = "https://#{city}.craigslist.org/search/apa?query=#{term}&postedToday=1&min_price=900&max_price=1500&min_bedrooms=2&availabilityMode=0&pets_dog=1"

    document = open(@base_url)
    parsed_content = Nokogiri::HTML(document.read)

    puts "\n===================================================================="
    puts "-                                                                  -"
    puts "-                     #{city} - #{term}"
    puts "-                                                                  -"
    puts "===================================================================="

    parsed_content.css('.content').css('.result-row').first(10).each do |row|
      options = {
        title: row.css('.hdrlnk').inner_text,
        posted_at: row.css('time').first.attributes["datetime"].value,
        price: row.css('.result-meta').css('.result-price').inner_text,
        neighborhood: row.css('.result-meta').css('.result-hood').inner_text,

        link: if row.css('.hdrlnk').first.attributes["href"].value[0] == '/'
          @link = "https://#{city}.craigslist.org" + row.css('.hdrlnk').first.attributes["href"]
          else @link = row.css('.hdrlnk').first.attributes["href"]
          end
        }

      Listing.new(options)
      puts "\n"
      puts "Title: #{options[:title]} - #{options[:neighborhood]}"
      puts "Price: #{options[:price]}"
      puts "Posted at #{options[:posted_at]}"
      puts options[:link]
      puts "\n"
      puts "-----------------------------------------------------------------\n"
      end
    end
  end

    # get '/' do
    #   @cities = @cities
    #   @searchTerms = ['condo', 'townhouse']
    #   erb :listings
    # end
