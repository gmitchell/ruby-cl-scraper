require 'pg'

class Listing
  attr_accessor :title, :posted_at, :price, :neighborhood, :link, :id

  def initialize(options = {})
    @title = options[:title] || 'n/a'
    @posted_at = options[:posted_at] || 'n/a'
    @price = options[:price] || 'n/a'
    @neighborhood = options[:neighborhood] || 'n/a'
    @link = options[:link] || 'n/a'
    @id = options[:id] || '0000'
  end

  def self.all
  end

  def find(id)
    db= PG.connect(dbname: 'clscrapes', user: 'cls', password: 'clscraper')
    results = db.exec_params("SELECT * from car_listings WHERE id = $1", [id]).first
    results
  end

  def save
    if @id == nil
      insert_record
    else
      update_record
    end

    # p @title, @posted_at, @price, @neighborhood, @link, @id
  end

  private

  def insert_record
  end

  def update_record
  end

end

