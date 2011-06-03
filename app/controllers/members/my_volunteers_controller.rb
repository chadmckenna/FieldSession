class Members::MyVolunteersController < Members::MembersController
  
  def index
    @volunteer_requests = PendingRequest.find(:all, :conditions => {:belongs_to_household_id => current_user.household.id, :pending => "true"})
    
    @households = Array.new
    
    for request in @volunteer_requests
      @household = Household.find_by_id(request.household_requestor_id)
      @households << @household
    end
  end
  
end