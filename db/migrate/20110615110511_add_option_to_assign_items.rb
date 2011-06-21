class AddOptionToAssignItems < ActiveRecord::Migration
  def self.up
    add_column :assign_items, :options, :text
  end

  def self.down
    remove_column :assign_items, :options
  end
end