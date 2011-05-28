class AddOierIndexToOjees < ActiveRecord::Migration
  def self.up
    add_column :ojees, :oier_id, :integer
  end

  def self.down
    remove_column :ojees, :oier_id
  end
end
