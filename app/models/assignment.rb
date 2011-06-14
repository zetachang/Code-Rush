class Assignment < ActiveRecord::Base
  has_many :items, :class_name => "AssignItem", :foreign_key => "assign_id", :dependent => :destroy
  validates_presence_of :title, :on => :create, :message => "can't be blank"
  serialize :assigned_to
end
