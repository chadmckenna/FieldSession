class Neighbor < ActiveRecord::Base
  belongs_to :neighbor, :class_name => 'Household'
  belongs_to :household
  
  before_create :set_default_read
  
  def set_default_read
    #self.read = "f"
  end

  def send_neighbor_request_email
  	UserMailer.deliver_neighbor_request_email(self)
  end

  def send_neighbor_confirmation_email
  	UserMailer.deliver_neighbor_confirmation_email(self)
  end
end
