class Members::MyVolunteersController < Members::MembersController
  helper :requests
  def index
    @my_requests = []
    @volunteer_requests = PendingRequest.find(:all, :conditions => {:belongs_to_household_id => current_user.household.id, :pending => "true"})
    all_my_requests = Request.find_all_by_household_id(current_user.household.id)
    for request in all_my_requests
      count = PendingRequest.find(:all, :conditions => {:request_id => request.id, :belongs_to_household_id => current_user.household.id, :confirmed => "true"}).count
      if count.eql? 0
        @my_requests << request
      end
    end
    @confirmed_requests = PendingRequest.find(:all, :conditions => {:belongs_to_household_id => current_user.household.id, :confirmed => "true"})
  end
  
  def add_caregiver
     @pending_request = PendingRequest.find(params[:pending_request_id])
     @pending_request.pending = "false"
     @pending_request.confirmed = "true"
     @pending_request.caregiver_commit_id = params[:caregiver_commit_id]
     @pending_request.save!
     @pending_request.send_volunteer_confirmed_email
     @caregiver_household = Household.find(@pending_request.caregiver_commit_id)
     @caregiver_household.credits += @pending_request.request.cost
     @household = @pending_request.request.household
     @household.credits -= @pending_request.request.cost
     @caregiver_household.save
     @household.save
     @pending_requests = PendingRequest.find(:all, :conditions => {:belongs_to_household_id => current_user.household.id, :pending => "true", :request_id => params[:request_id]})
     for pending_request in @pending_requests
       pending_request.destroy
     end
     flash[:success] = "You have successfully added that caregiver for this request"
     redirect_to members_requests_path
   end
end
