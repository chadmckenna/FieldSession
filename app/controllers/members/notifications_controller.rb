class Members::NotificationsController < Members::MembersController
  
  def update_read
    @neighbor_requests_confirmed = Neighbor.find(:all, :conditions => {:household_id => current_user.household.id, :household_confirmed => "t", :neighbor_confirmed => "t", :read => "f"})
    @pending_requests_confirmed =  PendingRequest.find(:all, :conditions => {:caregiver_commit_id => current_user.id, :confirmed => "true", :read => 'f'})
    @caregiver_requests = User.find(:all, :conditions => {:household_id => current_user.household_id, :household_confirmed => false})
    respond_to do |format|
      for pending_request in @pending_requests_confirmed
        pending_request.read = true
        pending_request.save!
      end
      for neighbor in @neighbor_requests_confirmed
        neighbor.read = true
        neighbor.save!
      end
      format.html { 
        if request.xhr?
          render :partial => 'layouts/notification'
        end 
      }
    end
  end
end