class Members::ProfileController < Members::MembersController
  def index
    @my_requests = Request.find_all_by_household_id(current_user.household.id)
    @household = current_user.household
    @num_requests = Request.find_all_by_household_id(@household.id).count
    @confirmed_requests = PendingRequest.find(:all, :conditions => {:household_requestor_id => current_user.household.id, :confirmed => "true"})
  end
end