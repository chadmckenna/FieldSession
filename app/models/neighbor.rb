class Neighbor < ActiveRecord::Base
  belongs_to :neighbor, :class_name => 'Household'
  belongs_to :household
  
  before_create :set_default_read
  
  def set_default_read
    #self.read = "f"
  end

  def send_neighbor_request_email(household)
    @users = User.find(:all, :conditions => {:household_id => household.id, :household_confirmed => true})
    for user in @users	 
      UserMailer.deliver_neighbor_request_email(self, user)
    end
  end

  def send_neighbor_confirmation_email(household)
  	UserMailer.deliver_neighbor_confirmation_email(self)
  end
end
