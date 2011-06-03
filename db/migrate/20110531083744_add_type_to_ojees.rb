class AddTypeToOjees < ActiveRecord::Migration
  def self.up
    add_column :ojees, :type, :string
    add_column :ojees, :problems_solved, :string
    Ojee.all.each{|c| c.destroy}
  end

  def self.down
    remove_column :ojees, :type
    remove_column :ojees, :problem_solved
  end
end