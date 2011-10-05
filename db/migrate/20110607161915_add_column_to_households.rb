class AddColumnToHouseholds < ActiveRecord::Migration
  def self.up
    add_column :households, :num_children, :integer, :null => false, :default => 0
  end

  def self.down
    remove_column :households, :num_children
  end
end
