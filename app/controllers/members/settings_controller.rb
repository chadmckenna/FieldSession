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
  
  def delete_account
    #@num_users_in_household = User.find_all_by_household_id(@user.household.id)
    @household = Household.find(current_user.household)
    @pending_requests = PendingRequest.find(:all, :conditions => {:belongs_to_household_id => current_user.household.id})
    @ask_requests = PendingRequest.find(:all, :conditions => {:household_requestor_id => current_user.household.id})
    
    unless current_user.household.users.count > 1
      @user.destroy
      for child in @household.children
        child.destroy
      end
      
      for request in @household.requests
        request.destroy
      end
      
      for pending_request in @pending_requests
        pending_request.destroy
      end
      
      for neighbor in @household.neighbors
        neighbor.destroy
        @neighbor = Neighbor.find_by_household_id(neighbor.neighbor_id)
        @neighbor.destroy
      end
      
      for ask_request in @ask_requests
        ask_request.destroy
      end
      
      for hidden_request in @household.hidden_requests
        hidden_request.destroy
      end
      
      current_user.household.destroy
      
      flash[:success] = "You have successfully deleted your account"
      redirect_to root_path
    else
      @user.destroy
      flash[:succes] = "You have successfully deleted your account"
      redirect_to root_path
    end
  end
end