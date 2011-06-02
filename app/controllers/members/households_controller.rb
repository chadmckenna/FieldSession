class Members::HouseholdsController < Members::MembersController
  skip_before_filter :require_household

  def show
    @household = Household.find(params[:id])
    @num_requests = Request.find_all_by_household_id(@household.id).count
    #unless @household.id.eql? current_user.household_id
     # flash[:error] = "You do not have permission to view that page."
     # redirect_to members_household_path(current_user.household)
    #end
    #redirect_to members_profile_path
  end

  def new
    @household = Household.new
    unless @household.id.eql? current_user.household_id
      flash[:error] = "You do not have permission to create that page."
      redirect_to members_household_path(current_user.household)
    end
  end

  def create
    if current_user.household_id.eql? nil
      @household = Household.new(params[:household])
      current_user.household = @household
      current_user.save!
      if @household.save
        flash[:success] = "Successfully created #{@household.name} household.  You're almost done!  Now add your children to your household."
        redirect_to new_members_child_path
      else
        flash[:error] = "Error creating household"
        render :action => 'new'
      end
    else
      flash[:error] = "You do not have permission to create that page."
      redirect_to members_children_path
    end
  end

  def edit
    @household = Household.find(params[:id])
    unless @household.id.eql? current_user.household_id
      flash[:error] = "You do not have permission to edit that page."
      redirect_to members_household_path(current_user.household)
    end
  end

  def update
    @household = Household.find(params[:id])
    if @household.id.eql? current_user.household_id
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
end
