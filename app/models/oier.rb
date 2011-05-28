class Oier < ActiveRecord::Base
  has_many :ojees
  validates_presence_of :name,:grade
end
