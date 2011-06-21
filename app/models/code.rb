class Code < ActiveRecord::Base
  acts_as_taggable
  acts_as_taggable_on :oj
  belongs_to :assign_item, :foreign_key => "item_id"
  #scope :by_user, lambda{|user| find_by_creator(user.name) }
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
