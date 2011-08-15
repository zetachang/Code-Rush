class AddVisibilityToCodes < ActiveRecord::Migration
  def self.up
    add_column :codes, :visibility, :boolean
  end

  def self.down
    remove_column :codes, :visibility
  end
end
