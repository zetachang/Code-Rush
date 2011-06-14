class AssignItem < ActiveRecord::Base
  belongs_to :assignment, :foreign_key => "assign_id"
  belongs_to :oier
  
  def owner
    self.oier.name
  end

end
