class Members::ProfileController < Members::MembersController
  helper :requests
  def index
    @my_requests = Request.find_all_by_household_id(current_user.household.id)
    @household = current_user.household
    @num_requests = Request.find_all_by_household_id(@household.id).count
    @commitments = PendingRequest.find(:all, :conditions => {:caregiver_requestor_id => current_user.id, :confirmed => "true"})
    @confirmed_requests = PendingRequest.find(:all, :conditions => {:belongs_to_household_id => current_user.household.id, :confirmed => "true"})
    @pending_requests = PendingRequest.find(:all, :conditions => {:caregiver_requestor_id => current_user.id, :pending => "true"})
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
