class Members::SettingsController < Members::MembersController
  
  def index
    @hidden_requests = HiddenRequest.find(:all, :conditions => {:household_hidden_id => nil, :household_id => current_user.household.id})
    @hidden_household_requests = HiddenRequest.find(:all, :conditions => {:request_id => nil, :household_id => current_user.household.id})
  end
  
  
  def edit
    @user = User.find(params[current_user])
  end
  
  def destroy
    @hidden_request = HiddenRequest.find(params[:id])
    @hidden_request.destroy
    flash[:success] = "You have successfully removed this household from your hidden households"
    redirect_to members_settings_path
    
  end
end