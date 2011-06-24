class AddItemIdToTutorial < ActiveRecord::Migration
  def self.up
    add_column :tutorials, :assign_item_id, :integer
  end

  def self.down
    remove_column :tutorials, :assign_item_id
  end
end