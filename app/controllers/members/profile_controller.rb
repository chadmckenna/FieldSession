class Members::ProfileController < Members::MembersController
  def index
    @my_requests = Request.find_all_by_household_id(current_user.household.id)
    @household = current_user.household
    @num_requests = Request.find_all_by_household_id(@household.id).count
  end
  
  def edit
    @household = current_user.household
    @edit = true
    unless @household.id.eql? current_user.household_id
      flash[:error] = "You do not have permission to edit that page."
      redirect_to members_household_path(current_user.household)
    end
  end

  def update
    @household = current_user.household
    if !@household.id.eql? current_user.household_id
      flash[:error] = "You do not have permission to update that page."
      redirect_to members_household_path(current_user.household)
    elsif @household.update_attributes(params[:household])
      flash[:success] = "Successfully updated #{@household.name} household."
      redirect_to members_household_path(@household)
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
