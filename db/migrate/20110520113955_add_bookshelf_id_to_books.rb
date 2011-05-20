class AddBookshelfIdToBooks < ActiveRecord::Migration
  def self.up
    add_column :books, :bookshelf_id, :integer
  end

  def self.down
    remove_column :books, :bookshelf_id
  end
end
