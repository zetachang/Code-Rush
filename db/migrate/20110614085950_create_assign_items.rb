class CreateAssignItems < ActiveRecord::Migration
  def self.up
    create_table :assign_items do |t|
      t.string :assign_type

      t.timestamps
    end
  end

  def self.down
    drop_table :assign_items
  end
end
