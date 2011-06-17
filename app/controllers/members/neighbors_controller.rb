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
      @neighbor.read = false
    
      @neighbor2 = Neighbor.new
      @neighbor2.neighbor_id = current_user.household.id
      @neighbor2.household_id = params[:household_id]
      @neighbor2.neighbor_confirmed = true
      @neighbor2.read = true
      @household = Household.find(params[:household_id])
      
      if @neighbor.save && @neighbor2.save
        @neighbor.send_neighbor_request_email(@neighbor)
        flash[:success] = "You have successfully added #{@household} as a neighbor"
        redirect_to :back
      else
        flash[:error] = "There were errors adding this neighbor"
        redirect_to :back
      end
    else
      flash[:error] = "It appears that there is already a neighbor request in the system to be neighbors. Check your neighbors request for a request from this user."
      redirect_to :back
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
      @neighbor.send_neighbor_confirmation_email(@neighbor)
      flash[:success] = "You have successfullly added #{@neighbor2.household.to_s} as a neighbor"
      redirect_to members_neighbors_path
    else
      flash[:error] = "There were errors adding this neighbor"
      redirect_to members_neighbors_path
    end
  end
  
  def destroy
    #current user
    @neighbor = Neighbor.find(params[:id])
    #find the current user's neighbor
    @neighbor2 = Neighbor.find(:first, :conditions => {:household_id => @neighbor.neighbor_id, :neighbor_id => @neighbor.household_id})
    
    @neighbor_users = User.find(:all, :conditions => {:household_id => @neighbor.household_id})
    @neighbor2_users = User.find(:all, :conditions => {:household_id => @neighbor2.household_id})
    
    #delete all pending requests that the neighbor has for your household
    for user in @neighbor_users
      puts user
      @pending_requests_neighbor_1 = PendingRequest.find(:all, :conditions => {:belongs_to_household_id => @neighbor2.household_id, :caregiver_requestor_id => user.id})
      for pending_request in @pending_requests_neighbor_1
        puts pending_request
        pending_request.destroy
      end
    end
    
    #delete all pending requests that you have requests for your neighbor
    for user in @neighbor2_users
      @pending_requests_neighbor_2 = PendingRequest.find(:all, :conditions => {:belongs_to_household_id => @neighbor.household_id, :caregiver_requestor_id => user.id})
      for pending_request in @pending_requests_neighbor_2
        pending_request.destroy
      end
    end
    
    if @neighbor.destroy && @neighbor2.destroy
      flash[:success] = "You have deleted your neighbor"
      redirect_to members_neighbors_path
    else
      flash[:error] = "There was an error deleting your neighbor"
      redirect_to members_neighbors_path
    end
  end
end