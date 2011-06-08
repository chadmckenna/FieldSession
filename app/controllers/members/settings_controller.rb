class Members::SettingsController < Members::MembersController
  before_filter :load_current_user
  def index
    @hidden_requests = HiddenRequest.find(:all, :conditions => {:household_hidden_id => nil, :household_id => current_user.household.id})
    @hidden_household_requests = HiddenRequest.find(:all, :conditions => {:request_id => nil, :household_id => current_user.household.id})
  end
  
  def destroy
    @hidden_request = HiddenRequest.find(params[:id])
    @hidden_request.destroy
    flash[:success] = "You have successfully removed this household from your hidden households"
    redirect_to members_settings_path
  end
  
    def load_current_user
      @user = User.find(current_user)
      @users = User.find_all_by_household_id(current_user.household.id)
    end
end