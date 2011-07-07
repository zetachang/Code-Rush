class Code < ActiveRecord::Base
  acts_as_taggable
  acts_as_taggable_on :oj
  belongs_to :assign_item, :foreign_key => "item_id"
  validate :tags_should_be_seperated_by_comma, :allow_blank => true
  validates_presence_of :title, :on => :create, :message => "can't be blank"
  validates_presence_of :source, :on => :create, :message => "can't be blank"
  #scope :by_user, lambda{|user| find_by_creator(user.name) }
  
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
  def status
    oier = Oier.find_by_name(self.creator)
    ojtype = self.assign_item.ojtype
    number = self.assign_item.number
    #begin
      if oier.ojee[ojtype].problems_solved.include?(number)
        return 'AC'
      else #which means it is Uploaded but failed
        return 'UF'
      end
    #rescue
    #  return 'SE'
    #end
  end

end
