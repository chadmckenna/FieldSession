class AddUserIdToRequests < ActiveRecord::Migration
  def self.up
    add_column :requests, :user_id, :integer
  end

  def self.down
    remove_column :requests, :user_id
  end
end
