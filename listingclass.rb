class Listing

  def initialize(options)
      @city = options[:city]
      @neighborhood = options[:neighborhood]
      @title = options[:title]
      @price = options[:price]
      @link = options[:link]
      @posted_time = options[:posted_time]
  end
end
