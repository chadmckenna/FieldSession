class Members::AddressesController < Members::MembersController
  skip_before_filter :require_address, :only => [:new, :create]
  def index
    @addresses = Address.all
  end

  def show
    @address = Address.find(params[:id])
  end

  def new
    @address = Address.new
  end

  def create
    @address = Address.new(params[:address])
    @address.household = current_user.household
    if @address.save
      flash[:success] = "Successfully created address.  Now let's add your children to your household."
      redirect_to new_members_child_path
    else
      render :action => 'new'
    end
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])
    if @address.update_attributes(params[:address])
      flash[:success] = "Successfully updated address."
      redirect_to members_settings_path
    else
      render :action => 'edit'
    end
  end

  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    flash[:success] = "Successfully destroyed address."
    redirect_to members_profile_path
  end
end
