class Members::MyVolunteersController < Members::MembersController
  
  def index
    @volunteer_requests = PendingRequest.find(:all, :conditions => {:belongs_to_household_id => current_user.household.id, :pending => "true"})
    @my_requests = Request.find_all_by_household_id(current_user.household.id)
  end
  
  def add_caregiver
     @pending_request = PendingRequest.find(params[:pending_request_id])
     @pending_request.pending = "false"
     @pending_request.confirmed = "true"
     @pending_request.household_commit_id = params[:household_commit_id]
     @pending_request.save!
     flash[:success] = "You have successfully added that caregiver for this request"
     redirect_to members_my_volunteers_path
   end
end