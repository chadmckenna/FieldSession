class Members::NotificationsController < Members::MembersController

  def update_read
    # YJB: How about current_user.confirmed_neighbor_requests
    @neighbor_requests_confirmed = Neighbor.find(:all, :conditions => {:household_id => current_user.household.id, :household_confirmed => "t", :neighbor_confirmed => "t", :read => "f"})
    # YJB: And current_user.confirmed_pending_requests
    @pending_requests_confirmed =  PendingRequest.find(:all, :conditions => {:caregiver_commit_id => current_user.id, :confirmed => "true", :read => 'f'})
    # YJB: Or better yet, current_user.requests(:type)
    #      Or if you want to get really wacky, use method_missing and metaprogramming techniques.
    @caregiver_requests = User.find(:all, :conditions => {:household_id => current_user.household_id, :household_confirmed => false})
    respond_to do |format|
      # YJB: I see disco balls in your future. Use @collection.each do |thing|
      for pending_request in @pending_requests_confirmed
        pending_request.read = true
        pending_request.save!
      end
      # YJB: Are you wearning roller skates? Use @collection.each do |thing|
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