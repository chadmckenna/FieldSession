class CreatePendingRequests < ActiveRecord::Migration
  def self.up
    create_table :pending_requests do |t|
      t.integer :request_id
      t.integer :household_requestor_id
      t.string :pending
      t.integer :household_commit_id
      t.string :confirmed

      t.timestamps
    end
  end

  def self.down
    drop_table :pending_requests
  end
end
