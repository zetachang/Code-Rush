class ChangeDescriptionToText < ActiveRecord::Migration
  def self.up
    remove_column :assign_items, :description 
    add_column :assign_items, :description, :text
  end

  def self.down
    remove_column :assign_items, :description
    add_column :assign_items, :description, :string
  end
end