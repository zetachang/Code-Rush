class Assignment < ActiveRecord::Base
  has_many :items, :class_name => "AssignItem", :foreign_key => "assign_id", :dependent => :destroy
  has_many :assigned_ship
  has_many :assigned_to, :through => :assigned_ship, :source => :oier 
  validates_presence_of :title, :on => :create, :message => "can't be blank"
  validates_length_of :assigned_to, :minimum => 1, :too_short => "At least assigned to one oier"
  validate :should_not_be_assigned_to_myself
  validate :should_not_assign_past_homework
  
  
  def should_not_assign_past_homework
    if self.due_time < DateTime.now
      errors.add(:due_time, "should be a future time")
    end
  end
  
  def should_not_be_assigned_to_myself
    if self.assigned_to.include?(User.find_by_username(self.setter).oier)
      errors.add(:assigned_to, "should not be assigned to youself") 
    end
  end
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
