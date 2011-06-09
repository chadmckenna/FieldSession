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
      @household.num_children = params[:child_count].to_i
      @household.credits = @household.num_children
      if @household.credits > 6
        @household.credits = 6
      end
      current_user.household = @household
      current_user.save!
      if @household.save
        flash[:success] = "Successfully created #{@household.name} household.  You're almost done!  Now add your children to your household."
        redirect_to new_members_child_path and return
      else
        flash[:error] = "Error creating household"
        render :action => 'new'
      end
    else
      flash[:error] = "You do not have permission to create that page."
      redirect_to members_children_path
    end
  end
  
  def to_s
    @household = Household.find(params[:id])
    @household.name
  end
end
