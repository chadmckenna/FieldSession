class Members::EmergencyContactsController < Members::MembersController
  def index
    @emergency_contacts = EmergencyContact.find_all_by_household_id(current_user.household_id)
  end
  
  def show
    @emergency_contact = EmergencyContact.find(params[:id])
    unless @contact.household_id.eql? current_user.household_id
      flash[:error] = "You do not have permission to view the details about this child."
      redirect_to members_emergency_contacts_path
    end
  end

  def new
    @emergency_contact = EmergencyContact.new
  end
  
  def create
    @emergency_contact = EmergencyContact.new(params[:emergency_contact])
    @emergency_contact.household = current_user.household
    if @emergency_contact.save
      flash[:success] = "Successfully added #{@emergency_contact.name} to the #{@emergency_contact.household}"
      redirect_to members_profile_path
    else
      render :action => 'new'
    end
  end
  
end