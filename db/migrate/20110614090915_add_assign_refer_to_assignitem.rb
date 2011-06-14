class AddAssignReferToAssignitem < ActiveRecord::Migration
  def self.up
    add_column :assign_items, :assign_id, :integer
  end

  def self.down
    remove_column :assign_items, :assign_id
  end
end