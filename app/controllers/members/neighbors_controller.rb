class Members::NeighborsController < Members::MembersController
  
  def index
    @neighbors = Neighbor.all
  end
  
  def new
    @neighbor = Neighbor.new
  end
  
  def create
    @neighbor = Neighbor.new(params[:neighbor])
    if @neighbor.save
      flash[:success] = "You have successfully added a new neighbor"
      redirect_to members_profile_path
    else
      flash[:error] = "There were errors adding this friend"
      render :action => "new"
  end

  def show
    @neighbor = Neighbor.find(params[:id])
  end
  
  def edit
    @neighbor = Neighbor.find(params[:id])
  end
  
  def update
    
  end
  
  def destroy
    
  end
end