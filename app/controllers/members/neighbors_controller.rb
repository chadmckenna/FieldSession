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
    @household = Household.find(params[:household_id])

    if @neighbor.save && @neighbor2.save
      flash[:success] = "You have successfully added #{@household} as a neighbor"
      redirect_to members_neighbors_path
    else
      flash[:error] = "There were errors adding this friend"
      redirect_to members_neighbors_path
    end
      
  end

  def show
    @neighbor = Neighbor.find(params[:id])
  end
  
  def destroy
    @neighbor = Neighbor.find(params[:id])
    @neighbor2 = Neighbor.find(:first, :conditions => {:household_id => @neighbor.neighbor_id, :neighbor_id => @neighbor.household_id})
    if @neighbor.destroy && @neighbor2.destroy
      flash[:success] = "You have deleted your neighbor"
      redirect_to members_neighbors_path
    else
      flash[:error] = "There was an error deleting your neighbor"
      redirect_to members_neighbors_path
    end
  end
end