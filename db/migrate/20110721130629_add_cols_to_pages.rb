class AddColsToPages < ActiveRecord::Migration
  def self.up
    add_column :pages, :commentable, :boolean
    add_column :pages, :comment_in_block, :boolean
  end

  def self.down
    remove_column :pages, :comment_in_block
    remove_column :pages, :commentable
  end
end