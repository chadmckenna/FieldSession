class Address < ActiveRecord::Base
  attr_accessible :street1, :street2, :city, :state, :zip, :household_id
  
  validates_presence_of :street1, :city, :state, :zip
  validates_numericality_of :zip
  validates_length_of :zip, :is => 5, :message => "must be 5 digits long."
  
  belongs_to :household
end
