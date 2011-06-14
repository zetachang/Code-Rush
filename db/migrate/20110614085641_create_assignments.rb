class CreateAssignments < ActiveRecord::Migration
  def self.up
    create_table :assignments do |t|
      t.string :title
      t.datetime :due_time
      t.string :setter
      t.text :assigned_to

      t.timestamps
    end
  end

  def self.down
    drop_table :assignments
  end
end
