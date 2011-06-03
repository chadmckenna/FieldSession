class Members::RequestsController < Members::MembersController

  def index
    @requests = Request.find(:all, :order => 'from_date')
    
    @pending_requests = PendingRequest.find(:all, :conditions => {:household_requestor_id => current_user.household.id, :pending => "true"})
    @pending_requests.sort!{|a, b| a.request.from_date <=> b.request.from_date}
    
    @confirmed_requests = PendingRequest.find(:all, :conditions => {:household_requestor_id => current_user.household.id, :confirmed => "true"})
    
    @volunteer_requests = PendingRequest.find(:all, :conditions => {:belongs_to_household_id => current_user.household.id, :pending => "true"})
  end

  def show
    @request = Request.find(params[:id])
  end

  def new
    @request = Request.new
  end

  def create
    @request = Request.new(params[:request])
    @request.household = current_user.household
    if @request.save
      flash[:success] = "Successfully created request."
      redirect_to members_request_path(@request)
    else
      render :action => 'new'
    end
  end

  def edit
    @request = Request.find(params[:id])
    @household = Request.find_by_household_id(@request.household_id)
    unless @request.household_id.eql? current_user.household_id
      flash[:error] = "You do not have permission to access this page."
      redirect_to members_request_path(@request)
    end
  end

  def update
    @request = Request.find(params[:id])
    if !@request.household_id.eql? current_user.household_id
      flash[:error] = "You do not have permission to access this page."
      redirect_to members_request_path(@request)
    elsif @request.update_attributes(params[:request])
      flash[:success] = "Successfully updated request."
      redirect_to members_request_path(@request)
    else
      render :action => 'edit'
    end
  end

  def destroy
    @request = Request.find(params[:id])
    if !@request.household_id.eql? current_user.household_id
      flash[:error] = "You do not have permission to access this page."
      redirect_to members_request_path(@request)
    else
      @request.destroy
      flash[:success] = "Successfully destroyed request."
      redirect_to members_household_path(current_user.household)
    end
  end
end
