class Members::UsersController < Members::MembersController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "Thank you for signing up! You are now logged in."
      redirect_to members_root_url
    else
      render :action => 'new'
    end
  end
  
  def update
    @user = User.find(params[:id])
    if !@user.household_id.eql? current_user.household_id
      flash[:error] = "You do not have permission to update this user."
      redirect_to members_profile_path
    elsif @user.update_attributes(params[:user])
      flash[:success] = "Successfully updated user profile."
      redirect_to members_settings_path
    else
      render :action => 'edit'
    end
  end
  
  def edit
    @user = User.find(params[:id])
    unless @user.household_id.eql? current_user.household_id
      flash[:error] = "You do not have permission to edit that page."
      redirect_to members_user_path(current_user)
    end
  end
  
  def show
    @user = User.find(params[:id])
  end
end
