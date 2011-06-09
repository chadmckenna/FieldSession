class Members::NeighborsController < Members::MembersController
  
  def index
    @neighbors = Neighbor.find(:all, :conditions => {:household_id => current_user.household_id, :household_confirmed => true, :neighbor_confirmed => true})
    @pending_neighbors = Neighbor.find(:all, :conditions => {:household_id => current_user.household_id, :household_confirmed => true, :neighbor_confirmed => false})
    @neighbor_requests = Neighbor.find(:all, :conditions => {:household_id => current_user.household_id, :household_confirmed => false, :neighbor_confirmed => true})
  end
  
  def new
    @neighbor = Neighbor.new
  end
  
  def create
    count = Neighbor.find(:all, :conditions => {:household_id => current_user.household_id, :neighbor_id => params[:household_id]}).count
    if count.eql? 0
      @neighbor = Neighbor.new
      @neighbor.neighbor_id = params[:household_id]
      @neighbor.household_id = current_user.household.id
      @neighbor.household_confirmed = true
    
      @neighbor2 = Neighbor.new
      @neighbor2.neighbor_id = current_user.household.id
      @neighbor2.household_id = params[:household_id]
      @neighbor2.neighbor_confirmed = true
      @household = Household.find(params[:household_id])
      
      if @neighbor.save && @neighbor2.save
        flash[:success] = "You have successfully added #{@household} as a neighbor"
        redirect_to members_neighbors_path
      else
        flash[:error] = "There were errors adding this neighbor"
        redirect_to members_neighbors_path
      end
    else
      flash[:error] = "It appears that there is already a neighbor request in the system to be neighbors. Check your neighbors request for a request from this user."
      redirect_to members_neighbors_path
    end  
  end

  def show
    @neighbor = Neighbor.find(params[:id])
  end
  
  def confirm
    @neighbor = Neighbor.find(params[:id])
    @neighbor2 = Neighbor.find(:first, :conditions => {:household_id => @neighbor.neighbor_id, :neighbor_id => @neighbor.household_id})
    @neighbor.household_confirmed = true
    @neighbor2.neighbor_confirmed = true
    
    if @neighbor.save && @neighbor2.save
      flash[:success] = "You have successfullly added #{@neighbor2.household.to_s} as a neighbor"
      redirect_to members_neighbors_path
    else
      flash[:error] = "There were errors adding this neighbor"
      redirect_to members_neighbors_path
    end
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