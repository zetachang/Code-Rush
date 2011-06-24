class AssignItem < ActiveRecord::Base
  belongs_to :assignment, :foreign_key => "assign_id"
  has_many :codes, :foreign_key => "item_id"
  has_one :tutorial
  serialize :options
  acts_as_taggable
  ASSIGN_TYPES = ['CODE','TEXT']
  ASSIGN_MAP = {'CODE' => 'code', 'TEXT' => 'tutorial'} 
  
  def short_name
    return self.ojtype + self.number
    if self.assign_type == 'CODE'
      return self.ojtype + self.number
    elsif self.assign_type == 'TEXT'
      return 'TEXT'
    end
  end
  
  #which is equavalent item.codes.find_by_creator(name)
  def code_by(oier)
    self.codes.find_by_creator(oier.name)
  end

end
