class Book < ActiveRecord::Base
  validates_presence_of :name, :image_url, :ISBN
  belongs_to :bookshelf
end
