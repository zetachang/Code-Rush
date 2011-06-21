class Code < ActiveRecord::Base
  acts_as_taggable
  acts_as_taggable_on :oj
  belongs_to :assign_item, :foreign_key => "item_id"
  #scope :by_user, lambda{|user| find_by_creator(user.name) }
  def status
    #UBF Uploaded but failed
    #AC
    return 'AC'
  end
end
