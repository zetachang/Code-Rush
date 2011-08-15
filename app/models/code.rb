class Code < ActiveRecord::Base
  acts_as_taggable
  acts_as_taggable_on :oj
  belongs_to :assign_item, :foreign_key => "item_id"
  belongs_to :oier
  validate :tags_should_be_seperated_by_comma, :allow_blank => true
  validates_presence_of :title, :on => :create, :message => "can't be blank"
  #validates_presence_of :source, :on => :create, :message => "can't be blank"
  def tags_should_be_seperated_by_comma
    return if self.tag_list == []
    self.tag_list.each do |tag|
      unless tag =~ /^[\sa-zA-Z0-9\-+]+$/
        errors.add(:tags,"should only contain characters,numbers,space and seperated by comma")
        return
      end
    end
  end
  
  def tags=(tags)
    self.tag_list = tags
  end
  
  def tags
    return self.tag_list
  end
  
#def visibility
#  if self[:visibility] == true
#    return "Public"
#  else
#    return "Private"
#  end
#end
#
#def visibility=(visi)
#  if visi == "Public"
#    self[:visibility] = true
#  else
#    self[:visibility] = false
#  end
#end
  def creator
    self.oier.name
  end
  
  def status
    oier = self.oier
    ojtype = self.assign_item.ojtype
    number = self.assign_item.prob_num
    begin
      if oier.ojee[ojtype].problems_solved.include?(number)
        return 'AC'
      else #which means it is Uploaded but failed
        return 'UF'
      end
    rescue
      return 'SE'
    end
  end

end
