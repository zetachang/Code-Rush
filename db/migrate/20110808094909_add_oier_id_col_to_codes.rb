class AddOierIdColToCodes < ActiveRecord::Migration
  def self.up
    change_table :codes do |t|
      t.remove :creator
      t.integer :oier_id
    end
  end

  def self.down
    change_table :codes do |t|
    end
  end
end