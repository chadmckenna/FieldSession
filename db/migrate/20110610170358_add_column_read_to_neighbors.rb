class AddColumnReadToNeighbors < ActiveRecord::Migration
  def self.up
    add_column :neighbors, :read, :string
  end

  def self.down
    remove_column :neighbors, :read
  end
end
