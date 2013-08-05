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
end
