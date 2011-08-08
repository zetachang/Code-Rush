class AddDescriptionColToAssignment < ActiveRecord::Migration
  def self.up
    add_column :assignments, :description, :text
  end

  def self.down
    remove_column :assignments, :description
  end
end