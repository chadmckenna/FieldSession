class Members::HouseholdsController < Members::MembersController
  skip_before_filter :require_household
  
  def index
    @households = Household.all
    @my_requests = Request.find_all_by_household_id(current_user.household.id)
  end

  def show
    @household = Household.find(params[:id])
  end

  def new
    @household = Household.new
  end

  def create
    @household = Household.new(params[:household])
    current_user.household = @household
    current_user.save!
    if @household.save
      flash[:success] = "Successfully created #{@household.name} household."
      redirect_to members_root_url
    else
      flash[:error] = "Error creating household"
      render :action => 'new'
    end
  end

  def edit
    @household = Household.find(params[:id])
  end

  def update
    @household = Household.find(params[:id])
    if @household.update_attributes(params[:household])
      flash[:success] = "Successfully updated #{@household.name} household."
      redirect_to @household
    else
      flash[:error] = "Error updating household"
      render :action => 'edit'
    end
  end

  def destroy
    @household = Household.find(params[:id])
    @household.destroy
    flash[:success] = "Successfully deleted #{@household.name} household."
    redirect_to households_url
  end
end
