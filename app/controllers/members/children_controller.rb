class Members::ChildrenController < Members::MembersController
    
  def index
    @children = Child.all
  end

  def show
    @child = Child.find(params[:id])
  end

  def new
    @child = Child.new
  end

  def create
    @child = Child.new(params[:child])
    @child.household = current_user.household
    
    if @child.save
      flash[:notice] = "Successfully created child."
      redirect_to members_children_path
    else
      render :action => 'new'
    end
  end

  def edit
    @child = Child.find(params[:id])
  end

  def update
    @child = Child.find(params[:id])
    if @child.update_attributes(params[:child])
      flash[:notice] = "Successfully updated child."
      redirect_to @child
    else
      render :action => 'edit'
    end
  end

  def destroy
    @child = Child.find(params[:id])
    @child.destroy
    flash[:notice] = "Successfully destroyed child."
    redirect_to children_url
  end
  
end
