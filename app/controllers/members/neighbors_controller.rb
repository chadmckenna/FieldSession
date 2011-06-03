class Members::NeighborsController < Members::MembersController
  
  def index
    @neighbors = Neighbor.find_all_by_household_id(current_user.household.id)
  end
  
  def new
    @neighbor = Neighbor.new
  end
  
  def create
    @neighbor = Neighbor.new
    @neighbor.neighbor_id = params[:household_id]
    @neighbor.household_id = current_user.household.id
    @neighbor2 = Neighbor.new
    @neighbor2.neighbor_id = current_user.household.id
    @neighbor2.household_id = params[:household_id]

    if @neighbor.save && @neighbor2.save
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