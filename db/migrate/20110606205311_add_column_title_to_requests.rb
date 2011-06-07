class AddColumnTitleToRequests < ActiveRecord::Migration
  def self.up
    add_column :requests, :title, :string
  end

  def self.down
    remove_column :requests, :title
  end
end
