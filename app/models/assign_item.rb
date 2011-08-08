class AssignItem < ActiveRecord::Base
  belongs_to :assignment, :foreign_key => "assign_id"
  has_many :codes, :foreign_key => "item_id"
  has_one :tutorial
  accepts_nested_attributes_for :tutorial
  acts_as_taggable
  ASSIGN_TYPES = ['CODE','TEXT']
  ASSIGN_MAP = {'CODE' => 'code', 'TEXT' => 'tutorial'} 
  
  
  
  def assignment_name
    self.assignment.title
  end
  
  def short_name
    self.ojtype + self.prob_num
  end
  
  def status_of(oier)
    self.codes.find_by_oier_id(oier).try(:status) || 'NA'
  end

  def handed_in_by?(oier)
    if self.status_by(oier) == 'AC' || self.status_by(oier) == 'Read'
      return true
    else
      return false
    end
  end
  
  

end
