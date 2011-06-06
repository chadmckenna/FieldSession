class CreateHiddenRequests < ActiveRecord::Migration
  def self.up
    create_table :hidden_requests do |t|
      t.integer :request_id
      t.integer :household_hidden_id
      t.integer :household_id

      t.timestamps
    end
  end

  def self.down
    drop_table :hidden_requests
  end
end
