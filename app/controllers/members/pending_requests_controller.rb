class Members::PendingRequestsController < Members::MembersController
  
  def index
    @pending_requests = PendingRequest.find_all_by_household_requestor_id(current_user.household.id)
    @pending_requests_count = PendingRequest.count
  end
  
  def new
    @pending_request = PendingRequest.new
  end
  
  def create
    @pending_request = PendingRequest.new
    @pending_request.request_id = params[:request_id]
    @pending_request.caregiver_requestor_id = current_user.id
    @pending_request.belongs_to_household_id = params[:belongs_to_household_id]
    @pending_request.read = false
    
    if @pending_request.save
      @pending_request.send_request_volunteered_email
      flash[:success] = "You have successfully volunteered for this request"
      redirect_to members_requests_path
    else
      flash[:error] = "There were errors volunteering for this request"
      redirect_to members_requests_path
    end
      
  end

  def show
    #@neighbor = Neighbor.find(params[:id])
  end
  
  def destroy
    @pending_request = PendingRequest.find(params[:id])
    @pending_request.destroy
    flash[:success] = "Pending request has been successfully deleted"
    redirect_to members_requests_path
  end
end