class Members::NeighborsController < Members::MembersController
  
  def index
    @neighbors = current_user.get_my_neighbors
    @pending_neighbors = current_user.get_my_pending_neighbors
    @neighbor_requests = current_user.get_my_neighbor_requests
  end
  
  def new
    @neighbor = Neighbor.new
  end
  
  def create
    if !current_user.is_neighbor?(params[:household_id])
      if current_user.add_neighbor(params[:household_id])
        # I broke this when I abstracted the addition of neighbors to the user model.
        # maybe we should return the @neighbor so that we can send the email.
        # thoughts?
        #@neighbor.send_neighbor_request_email(@neighbor)
        flash[:success] = "You have successfully requested to add #{@household} as a neighbor"
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
      flash[:success] = "Success!"
      redirect_to :back
    else
      flash[:error] = "There was an error deleting your neighbor"
      redirect_to :back
    end
  end
end