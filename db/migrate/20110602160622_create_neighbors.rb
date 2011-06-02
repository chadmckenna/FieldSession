class CreateNeighbors < ActiveRecord::Migration
  def self.up
    create_table :neighbors do |t|
      t.integer :household_id
      t.integer :household_id_neighbor
      t.timestamps
    end
  end

  def self.down
    drop_table :neighbors
  end
end
