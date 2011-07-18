class Neighbor < ActiveRecord::Base
  belongs_to :neighbor, :class_name => 'Household'
  belongs_to :household
  
  before_create :set_default_read
  
  def set_default_read
    #self.read = "f"
  end

  def send_neighbor_request_email(neighbor)
    @users = User.find(:all, :conditions => {:household_id => neighbor.neighbor_id, :household_confirmed => true})
    for user in @users
  	 UserMailer.deliver_neighbor_request_email(self, user)
    end
  end

  def send_neighbor_confirmation_email(neighbor)
    @users = User.find(:all, :conditions => {:household_id => neighbor.neighbor_id, :household_confirmed => true})
    for user in @users
  	 UserMailer.deliver_neighbor_confirmation_email(self, user)
   end
  end
  
  def self.get_my_neighbors(current_user)
    return Neighbor.find(:all, :conditions => {:household_id => current_user.household_id, :household_confirmed => true, :neighbor_confirmed => true})
  end
  
  def self.get_my_pending_neighbors(current_user)
    return Neighbor.find(:all, :conditions => {:household_id => current_user.household_id, :household_confirmed => true, :neighbor_confirmed => false})
  end
  
  def self.get_my_neighbor_requests(current_user)
    return Neighbor.find(:all, :conditions => {:household_id => current_user.household_id, :household_confirmed => false, :neighbor_confirmed => true})
  end
  
  def self.can_render?(neighbors)
    true if neighbors.count > 0    
  end
end
