class CreateAssignedShips < ActiveRecord::Migration
  def self.up
    create_table :assigned_ships do |t|
      t.integer :assignment_id
      t.integer :oier_id

      t.timestamps
    end
  end

  def self.down
    drop_table :assigned_ships
  end
end
