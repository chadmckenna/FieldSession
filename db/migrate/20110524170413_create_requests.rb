class CreateRequests < ActiveRecord::Migration
  def self.up
    create_table :requests do |t|
      t.datetime :date
      t.datetime :start_time
      t.datetime :end_time
      t.integer :user_id
      t.decimal :cost
      t.timestamps
    end
  end

  def self.down
    drop_table :requests
  end
end
