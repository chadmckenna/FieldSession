class Members::HouseholdsController < Members::MembersController
  skip_before_filter :require_household#, :only => [:join_request, :new, :create]
  skip_before_filter :require_address, :only => [:new, :create, :join_request]
  filter_access_to :all
  

  def show
    if current_user.is_neighbor?(params[:id])
      @household = Household.find(params[:id])
      @num_requests = Request.find_all_by_household_id(@household.id).count
    else
      flash[:error] = "You are not neighbors with this person."
      redirect_to :back
    end
  end

  def new
    @household = Household.new
    unless @household.id.eql? current_user.household_id
      if !current_user.household_confirmed.eql? true
        flash[:error] = "You have not yet been confirmed to a household"
        redirect_to root_path
      else
        flash[:error] = "You do not have permission to create that page."
        redirect_to members_household_path(current_user.household)
      end
    end
  end

  def create
    if current_user.household_id.eql? nil
      @household = Household.new(params[:household])
      @household.num_children = params[:child_count].to_i
      @household.credits = @household.num_children
      current_user.household_confirmed = true
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
    elsif current_user.household_confirmed != 1
        flash[:error] = "You are not yet confirmed for a household"
        redirect_to root_path
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

  def join_request
    @household = Household.find(params[:household_id])
    @caregiver = current_user
    @caregiver.household_id = params[:household_id]
    @caregiver.household_confirmed = 0
    if @caregiver.save
      @caregiver.send_household_join_request_email(@household)
      flash[:success] = "You've sent a request to join the #{@household.name} household. You will recieve an email if your request is accepted"
      redirect_to root_url
    else
      flash[:error] = "An error has occured in the request to join a household"
      redirect_to root_url
    end
  end

  def confirm
    @caregiver = User.find(params[:user])
    @caregiver.household_confirmed = true
    if @caregiver.save
      @caregiver.send_household_join_confirmation_email
      flash[:success] = "#{@caregiver} has successfully been added to your household"
      redirect_to members_profile_path
    else
      flash[:error] = "There were errors in adding this user to your household"
      redirect_to members_profile_path
    end
  end

  def remove_caregiver
    @caregiver = User.find(params[:user])
    @caregiver.household_confirmed = false
    @caregiver.household_id = nil
    if @caregiver.save
      flash[:success] = "#{@caregiver} has successfully been removed"
      redirect_to members_profile_path
    else
      flash[:error] = "An error has occured while trying to remove a caregiver"
      redirect_to members_profile_path
    end
  end

  def update
    @household = Household.find(params[:id])
    if !@household.id.eql? current_user.household_id
      flash[:error] = "You do not have permission to update that page."
      redirect_to members_settings_path
    elsif @household.update_attributes(params[:household])
      flash[:success] = "Successfully updated #{@household.name} household."
      redirect_to members_settings_path
    else
      flash[:error] = "Error updating household"
      redirect_to members_settings_path
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
