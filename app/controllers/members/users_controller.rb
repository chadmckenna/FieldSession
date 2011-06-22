class Members::UsersController < Members::MembersController
  skip_before_filter :require_household, :only => [:new, :create, :add, :show, :edit, :update]
  
  def index
    @caregivers = User.find(:all, :conditions => {:household_id => current_user.household_id, :household_confirmed => true})
    @pending_caregivers = User.find(:all, :conditions => {:household_id => current_user.household_id, :household_confirmed => false})
  end
  
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
      if @user.household_confirmed.eql? false
        redirect_to members_user_path(@user)
      else
        redirect_to members_settings_path
      end
    else
      render :action => 'edit'
    end
  end
  
  def add#_to_household
    @user = current_user
    @user.send_welcome_email
    @user.household_id = params[:household_id]
    if @user.save
      @user.send_welcome_email
      flash[:success] = "You've sent a request to be added to the household"
      redirect_to root_url
    else
      flash[:error] = "Something went wrong"
      redirect_to root_url
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
