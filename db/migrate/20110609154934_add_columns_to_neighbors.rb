class AddColumnsToNeighbors < ActiveRecord::Migration
  def self.up
    add_column :neighbors, :household_confirmed, :boolean, :default => false
    add_column :neighbors, :neighbor_confirmed, :string, :default => false
  end

  def self.down
    remove_column :neighbors, :neighbor_confirmed
    remove_column :neighbors, :household_confirmed
  end
end
