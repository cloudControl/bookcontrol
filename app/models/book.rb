class Book
  include Mongoid::Document

  belongs_to :user

  field :isbn, type: String
  field :title, type: String
  field :author, type: String
  field :publisher, type: String
  field :category, type: String
  field :img_url, type: String
  field :amazon_link, type: String
  field :proposal, type: Boolean

  validates_format_of :img_url, :with => /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix
  validates_format_of :amazon_link, :with => /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix
  
  def self.search(query)
    Book.any_of(
      {isbn: /#{query}/i},
      {author: /#{query}/i},
      {title: /#{query}/i})
  end
end
