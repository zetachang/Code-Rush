class CreateOjees < ActiveRecord::Migration
  def self.up
    create_table :ojees do |t|
      t.string :ojtype
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :ojees
  end
end
