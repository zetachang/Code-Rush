class CreateOiers < ActiveRecord::Migration
  def self.up
    create_table :oiers do |t|
      t.string :name
      t.integer :grade
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :oiers
  end
end
