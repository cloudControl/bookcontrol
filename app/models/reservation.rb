class Reservation
  include Mongoid::Document
  include Mongoid::MultiParameterAttributes
  field :begin_date, type: Time
  field :return_date, type: Time, :default => nil

  has_many :books
  has_many :users
  scope :recent, order_by(:begin_date => :desc)
end
