class RemoveDummyTable < ActiveRecord::Migration
  def self.up
    drop_table :books
    drop_table :posts
    drop_table :bookshelves
  end

  def self.down
  end
end
