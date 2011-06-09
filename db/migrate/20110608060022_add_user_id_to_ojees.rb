class AddUserIdToOjees < ActiveRecord::Migration
  def self.up
    add_column :ojees, :userid, :integer
  end

  def self.down
    remove_column :ojees, :userid
  end
end