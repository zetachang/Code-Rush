class ChangeAssignsTable < ActiveRecord::Migration
  def self.up
    remove_column :assignments, :assigned_to
  end

  def self.down
    add_column :assignments, :assigned_to, :text
  end
end
