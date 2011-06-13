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
  
  def new_multiple
    
  end

  def create
    @child = Child.new(params[:child])
    @household = current_user.household
    @child.household = @household
    
    if @household.num_children < @household.children.count
      @household.num_children = @household.children.count
    end
    
    if @child.save and @household.save!
      case params[:commit]
      when 'Add another child' 
        flash[:success] = "Sucessfully added #{@child.first_name} to your household.  Add another child."
        redirect_to new_members_child_path
      else
        flash[:success] = "Successfully added #{@child.first_name} to the #{@child.household} household."
        redirect_to new_members_emergency_contact_path
      end
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
