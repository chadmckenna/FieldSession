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
      if @household.credits > 6 # maximum number of credits per user
        @household.credits = 6
      end
      current_user.household = @household
      current_user.save!
      if @household.save
        flash[:success] = "Successfully created #{@household.name} household.  You're almost done!  Now add your address to your household."
        redirect_to new_members_address_path and return
      else
        flash[:error] = "Error creating household"
        render :action => 'new'
      end
    else
      flash[:error] = "You do not have permission to create that page."
      redirect_to members_profile_path
    end
  end

  def edit
    @household = Household.find(params[:id])
    @edit = true
    unless @household.id.eql? current_user.household_id
      flash[:error] = "You do not have permission to edit that page."
      redirect_to members_profile_path
    end
  end

  def update
    @household = Household.find(params[:id])
    if !@household.id.eql? current_user.household_id
      flash[:error] = "You do not have permission to update that page."
      redirect_to members_household_path(current_user.household)
    elsif @household.update_attributes(params[:household])
      flash[:success] = "Successfully updated #{@household.name} household."
      redirect_to members_profile_path
    else
      flash[:error] = "Error updating household"
      render :action => 'edit'
    end
  end
  
  def address_attributes=(address_attributes)
    address_attributes.each do |attributes|
      addresses.build(attributes)
    end
  end
  
  def to_s
    @household = Household.find(params[:id])
    @household.name
  end
end
