class Members::SettingsController < Members::MembersController
  
  def index
    @hidden_requests = HiddenRequest.find(:all, :conditions => {:request_id => !nil})
  end
  
  
  def edit
    @user = User.find(params[current_user])
  end
  
  def update
    
  end
end