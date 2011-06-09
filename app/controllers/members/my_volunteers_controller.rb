class Members::MyVolunteersController < Members::MembersController
  helper :requests
  def index
    @volunteer_requests = PendingRequest.find(:all, :conditions => {:belongs_to_household_id => current_user.household.id, :pending => "true"})
    @my_requests = Request.find_all_by_household_id(current_user.household.id)
    @confirmed_requests = PendingRequest.find(:all, :conditions => {:belongs_to_household_id => current_user.household.id, :confirmed => "true"})
  end
  
  def add_caregiver
     @pending_request = PendingRequest.find(params[:pending_request_id])
     @pending_request.pending = "false"
     @pending_request.confirmed = "true"
     @pending_request.caregiver_commit_id = params[:caregiver_commit_id]
     @pending_request.save!
     @pending_requests = PendingRequest.find(:all, :conditions => {:belongs_to_household_id => current_user.household.id, :pending => "true", :request_id => params[:request_id]})
     for pending_request in @pending_requests
       pending_request.destroy
     end
     @pending_request.send_volunteer_confirmed_email
     flash[:success] = "You have successfully added that caregiver for this request"
     redirect_to members_my_volunteers_path
   end
end