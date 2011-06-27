class AssignItem < ActiveRecord::Base
  belongs_to :assignment, :foreign_key => "assign_id"
  has_many :codes, :foreign_key => "item_id"
  has_one :tutorial
  accepts_nested_attributes_for :tutorial
  acts_as_taggable
  ASSIGN_TYPES = ['CODE','TEXT']
  ASSIGN_MAP = {'CODE' => 'code', 'TEXT' => 'tutorial'} 
  
  def short_name
    #return self.ojtype + self.number
    if self.assign_type == 'CODE'
      return self.ojtype + self.number
    elsif self.assign_type == 'TEXT'
      return 'TEXT'
    end
  end
  
  def status_by(oier)
    if self.assign_type == 'CODE'
      return self.codes.find_by_creator(oier.name).try(:status) || 'NA'
    elsif self.assign_type == 'TEXT'
      if self.tutorial.reader_list.include?(oier.name)
        return 'Read'
      else
        return 'Unread'
      end
    end
  end

  def handed_in_by?(oier)
    if self.status_by(oier) == 'AC' || self.status_by(oier) == 'Read'
      return true
    else
      return false
    end
  end
  
  

end
