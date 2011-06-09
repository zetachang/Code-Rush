class Oier < ActiveRecord::Base
  has_many :ojees, :dependent => :delete_all 
  belongs_to :user
  validates_presence_of :name,:grade
  validates_uniqueness_of :name, :on => :create, :message => "must be unique"
  def ojee
    hash = Hash.new
    Ojee::OJ_TYPES.each do |ojtype|
      hash[ojtype] = self.ojees.find_by_type(Ojee::OJ_MAP[ojtype])
    end
    hash
  end
end
