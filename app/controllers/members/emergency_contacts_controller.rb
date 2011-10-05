class Members::EmergencyContactsController < Members::MembersController
  def index
    @emergency_contacts = EmergencyContact.find_all_by_household_id(current_user.household_id)
  end
  
  def show
    @emergency_contact = EmergencyContact.find(params[:id])
    unless @emergency_contact.household_id.eql? current_user.household_id
      flash[:error] = "You do not have permission to view the details about this child."
      redirect_to members_emergency_contacts_path
    end
  end
  
  def edit
    @emergency_contact = EmergencyContact.find(params[:id])
  end
  

  def new
    @emergency_contact = EmergencyContact.new
  end
  
  def create
    @emergency_contact = EmergencyContact.new(params[:emergency_contact])
    @emergency_contact.household = current_user.household
    if @emergency_contact.save
      case params[:commit]
      when 'Add another emergency contact' 
        flash[:success] = "Sucessfully added #{@emergency_contact.name} to your household.  Add another emergency contact."
        redirect_to new_members_emergency_contact_path
      else
        flash[:success] = "Successfully added #{@emergency_contact.name} to the #{@emergency_contact.household}"
        redirect_to members_profile_path
      end
    else
      case params[:commit]
      when 'Skip'
        flash[:success] = "No emergency contacts added to your household. You can add more by editing the emergency contacts section under your household image."
        redirect_to members_profile_path
      else
        render :action => 'new'
      end
    end
  end
  
  def edit
    @emergency_contact = EmergencyContact.find(params[:id])
    unless @emergency_contact.household_id.eql? current_user.household_id
      flash[:error] = "You do not have permission to edit the details of emergency contact."
      redirect_to members_emergency_contact_path
    end
  end

  def update
    @emergency_contact = EmergencyContact.find(params[:id])
    if !@emergency_contact.household_id.eql? current_user.household_id
      flash[:error] = "You do not have permission to view the details of emergency contact."
      redirect_to members_emergency_contact_path
    elsif @emergency_contact.update_attributes(params[:emergency_contact])
      flash[:success] = "Successfully updated emergency_contact."
      redirect_to members_settings_path
    else
      render :action => 'edit'
    end
  end
  
  
  def destroy
    @emergency_contact = EmergencyContact.find(params[:id])
    @emergency_contact.destroy
    flash[:success] = "Successfully destroyed address."
    redirect_to members_emergency_contacts_path
  end
  
end