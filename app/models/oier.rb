class Oier < ActiveRecord::Base
  has_many :objects, :dependent => :delete_all 
  has_many :ojees
  validates_presence_of :name,:grade
  def ojee
    hash = Hash.new
    Ojee::OJ_TYPES.each do |ojtype|
      hash[ojtype] = self.ojees.find_by_type(Ojee::OJ_MAP[ojtype])
    end
    hash
  end
end
