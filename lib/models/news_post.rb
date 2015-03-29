require 'rdiscount'

class NewsPost
  include DataMapper::Resource

  property :id, Serial
  property :title, String
  property :body, Text
  property :created_at, Time

  def body_as_html
    RDiscount.new(body).to_html
  end
end
