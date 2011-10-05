class EmergencyContact < ActiveRecord::Base
  belongs_to :household
  #attr_accessible :name, :relationship, :phone
  
  validates_presence_of :name, :relationship
  validates_format_of :phone,
      :message => "must be a valid telephone number.",
      :with => /^[\(\)0-9\- \+\.]{10,20}$/
      
  
end
