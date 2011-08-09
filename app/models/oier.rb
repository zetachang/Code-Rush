class Oier < ActiveRecord::Base
  belongs_to :user
  has_many :ojees, :dependent => :delete_all 
  has_many :assigned_ship
  has_many :assignment, :through => :assigned_ship 
  has_many :codes
  validates_presence_of :name, :grade
  validates_uniqueness_of :name, :on => :create, :message => "must be unique"
  def ojee
    hash = Hash.new
    Ojee::OJ_TYPES.each do |ojtype|
      hash[ojtype] = self.ojees.find_by_ojtype(ojtype)
    end
    hash
  end
  
  def to_param
    self.name.parameterize
  end
end
