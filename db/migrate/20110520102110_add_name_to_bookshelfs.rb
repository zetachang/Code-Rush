class AddNameToBookshelfs < ActiveRecord::Migration
  def self.up
    add_column :bookshelves, :name, :string
  end

  def self.down
    remove_column :bookshelves, :name
  end
end
