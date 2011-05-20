class Comment < ActiveRecord::Base
  validates_presence_of :name, :body
  belongs_to :post
end
