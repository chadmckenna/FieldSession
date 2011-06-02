class CreateNeighbors < ActiveRecord::Migration
  def self.up
    create_table :neighbors, :id => false do |t|
      t.integer :household_id
      t.integer :neighbor_id
      t.timestamps
    end
  end

  def self.down
    drop_table :neighbors
  end
end
