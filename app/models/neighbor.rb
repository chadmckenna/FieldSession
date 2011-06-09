class Neighbor < ActiveRecord::Base
  belongs_to :neighbor, :class_name => 'Household'
  belongs_to :household

  def send_neighbor_request_email
  	UserMailer.deliver_neighbor_request_email(self)
  end
end
