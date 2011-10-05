class AddNotesToRequest < ActiveRecord::Migration
  def self.up
    add_column :requests, :notes, :string
  end

  def self.down
    remove_column :requests, :notes
  end
end
