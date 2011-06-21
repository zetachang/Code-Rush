class AddTitleAndDescriptToItems < ActiveRecord::Migration
  def self.up
    add_column :assign_items, :title, :string
    add_column :assign_items, :description, :string
  end

  def self.down
    remove_column :assign_items, :description
    remove_column :assign_items, :title
  end
end