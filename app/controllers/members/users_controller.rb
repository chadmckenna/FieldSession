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
  
  def edit
    flash[:success] = "This is where you'd edit your info."
    redirect_to members_root_url
  end
end
