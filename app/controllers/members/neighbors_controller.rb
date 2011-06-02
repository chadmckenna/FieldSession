class Members::NeighborsController < Members::MembersController
  
  def index
    @neighbors = Neighbor.all
  end
  
  def new
    @neighbor = Neighbor.new
  end
  
  def create
    @neighbor = Neighbor.new
    #@neighbor.household_id = current_user.household.id
    #@neighbor.household = params[:household]
    @neighbor.neighbor_id = params[:household_id]
    @neighbor.household_id = current_user.household
    if @neighbor.save
      flash[:success] = "You have successfully added a new neighbor"
      redirect_to members_profile_path
    else
      flash[:error] = "There were errors adding this friend"
      redirect_to members_requests_path
    end
  end

  def show
    @neighbor = Neighbor.find(params[:id])
  end
  
  def destroy
    @neighbor = Neighbor.find(params[:id])
    @neighbor.destroy
    flash[:success] = "You have deleted your neighbor"
    redirect_to members_root_path
  end
end