class ChangeAssignItemTable < ActiveRecord::Migration
  def self.up
    change_table :assign_items do |t|
      t.remove :assign_type
      t.rename :options, :tags
      t.rename :number, :prob_num
      
    end
  end

  def self.down
    change_table :assgine_items do |t|
    end
  end
end