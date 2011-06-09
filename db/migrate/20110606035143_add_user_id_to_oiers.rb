class AddUserIdToOiers < ActiveRecord::Migration
  def self.up
    add_column :oiers, :user_id, :integer
  end

  def self.down
    remove_column :oiers, :user_id
  end
end