class EmergencyContact < ActiveRecord::Base
  belongs_to :household
  attr_accessible :name, :relationship, :phone
  
  
end
