class Members::ChildrenController < Members::MembersController
    
  def index
    @children = Child.find_all_by_household_id(current_user.household_id)
  end

  def show
    @child = Child.find(params[:id])
    unless @child.household_id.eql? current_user.household_id
      flash[:error] = "You do not have permission to view the details about this child."
      redirect_to members_children_path
    end
  end

  def new
    @child = Child.new
  end

  def create
    @child = Child.new(params[:child])
    @child.household = current_user.household
    
    if @child.save
      flash[:success] = "Successfully added #{@child.first_name} to the #{@child.household} household."
      redirect_to members_profile_path
    else
      render :action => 'new'
    end
  end

  def edit
    @child = Child.find(params[:id])
    unless @child.household_id.eql? current_user.household_id
      flash[:error] = "You do not have permission to edit the details of this child."
      redirect_to members_children_path
    end
  end

  def update
    @child = Child.find(params[:id])
    if !@child.household_id.eql? current_user.household_id
      flash[:error] = "You do not have permission to view the details of this child."
      redirect_to members_children_path
    elsif @child.update_attributes(params[:child])
      flash[:notice] = "Successfully updated child."
      redirect_to members_child_path(@child)
    else
      render :action => 'edit'
    end
  end

  def destroy
    @child = Child.find(params[:id])
    @child.destroy
    flash[:notice] = "Successfully destroyed child."
    redirect_to members_children_path
  end
  
end
