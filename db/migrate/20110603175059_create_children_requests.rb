class CreateChildrenRequests < ActiveRecord::Migration
  def self.up
    create_table :children_requests, :id => false do |t|
      t.integer :child_id
      t.integer :request_id

      t.timestamps
    end
  end

  def self.down
    drop_table :children_requests
  end
end
