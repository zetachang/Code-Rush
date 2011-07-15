class DropComments < ActiveRecord::Migration
  def self.up
    drop_table :comments
  end

  def self.down
  end
end
