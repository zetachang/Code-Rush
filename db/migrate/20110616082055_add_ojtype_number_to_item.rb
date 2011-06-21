class AddOjtypeNumberToItem < ActiveRecord::Migration
  def self.up
    add_column :assign_items, :ojtype, :string
    add_column :assign_items, :number, :string
  end

  def self.down
    remove_column :assign_items, :number
    remove_column :assign_items, :ojtype
  end
end