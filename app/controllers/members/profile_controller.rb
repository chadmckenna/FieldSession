class Members::ProfileController < Members::MembersController
  helper :requests
  def index
    @my_requests = Request.find_all_by_household_id(current_user.household.id)
    @household = current_user.household
    @num_requests = Request.find_all_by_household_id(@household.id).count
    @commitments = PendingRequest.find(:all, :conditions => {:caregiver_requestor_id => current_user.id, :confirmed => "true"})
    
    @confirmed_requests = []
    confirmed_requests = PendingRequest.find(:all, :conditions => {:belongs_to_household_id => current_user.household.id, :confirmed => "true"})
    for confirmed_request in confirmed_requests
      request = Request.find_by_id(confirmed_request.request_id)
      end_time = Time.local(request.to_date.year, request.to_date.month, request.to_date.day, request.end_time.hour, request.end_time.min)
      if end_time > Time.now
        @confirmed_requests << confirmed_request 
      end
    end
    
    @pending_commitments = []
    pending_commitments = PendingRequest.find(:all, :conditions => {:caregiver_requestor_id => current_user.id, :pending => "true"})
    for pending_commitment in pending_commitments
      request = Request.find_by_id(pending_commitment.request_id)
      end_time = Time.local(request.to_date.year, request.to_date.month, request.to_date.day, request.end_time.hour, request.end_time.min)
      if (end_time > Time.now) 
          @pending_commitments << pending_commitment
      end
    end
            
    @open_requests = []
    open_requests = Request.find(:all, :conditions => {:household_id => current_user.household.id, :is_completed => "f"})
    for open_request in open_requests
      end_time = Time.local(open_request.to_date.year, open_request.to_date.month, open_request.to_date.day, open_request.end_time.hour, open_request.end_time.min)
      if (end_time > Time.now)
        @open_requests << open_request
      end
    end
  end
  
  def edit
    @household = current_user.household
    @edit = true
    unless @household.id.eql? current_user.household_id
      flash[:error] = "You do not have permission to edit that page."
      redirect_to members_profile_path
    end
  end

  def update
    @household = current_user.household
    if !@household.id.eql? current_user.household_id
      flash[:error] = "You do not have permission to update that page."
      redirect_to members_profile_path
    elsif @household.update_attributes(params[:household])
      flash[:success] = "Successfully updated #{@household.name} household."
      redirect_to members_profile_path
    else
      flash[:error] = "Error updating household"
      render :action => 'edit'
    end
  end
  
  def to_s
    @household = current_user.household
    @household.name
  end

end
