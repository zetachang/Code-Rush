class Assignment < ActiveRecord::Base
  has_many :items, :class_name => "AssignItem", :foreign_key => "assign_id", :dependent => :destroy
  has_many :assigned_ship
  has_many :assigned_to, :through => :assigned_ship, :source => :oier 
  validates_presence_of :title, :on => :create, :message => "can't be blank"
  
  def locked?
    if self.due_time < DateTime.now
      return true
    else
      return false
    end
  end
  
  def due?
    self.due_time < DateTime.now
  end
end
