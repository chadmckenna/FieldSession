class AddPhoneToHouseholds < ActiveRecord::Migration
  def self.up
    add_column :households, :home_phone, :string
  end

  def self.down
    remove_column :households, :home_phone
  end
end
