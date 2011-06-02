class CreateNeighbors < ActiveRecord::Migration
  def self.up
    create_table :neighbors do |t|
      t.integer :user_id
      t.integer :user_id_neighbor
      t.timestamps
    end
  end

  def self.down
    drop_table :neighbors
  end
end
