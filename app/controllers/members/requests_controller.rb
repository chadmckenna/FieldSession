class Members::RequestsController < Members::MembersController
  filter_access_to :all
  def index
    @requests = Request.find(:all, :order => 'from_date')
    @my_requests = Request.find_all_by_household_id(current_user.household.id)
    @pending_requests = PendingRequest.find(:all, :conditions => {:household_requestor_id => current_user.household.id, :pending => "true"})
    @pending_requests.sort!{|a, b| a.request.from_date <=> b.request.from_date}
    
    @confirmed_requests = PendingRequest.find(:all, :conditions => {:household_requestor_id => current_user.household.id, :confirmed => "true"})

    @num_volunteer_requests = PendingRequest.find(:all, :conditions => {:belongs_to_household_id => current_user.household.id, :pending => "true"}).count
    
    @hidden_requests = HiddenRequest.find_all_by_household_id(current_user.household.id)
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
    params[:request][:child_ids] ||= []
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
  
  def hide_request
    @hidden_request = HiddenRequest.new
    @hidden_request.request_id = params[:request_id]
    @hidden_request.household = current_user.household
    if @hidden_request.save
      flash[:success] = "You have hidden this request"
      redirect_to members_requests_path
    else
      flash[:error] = "There was an error hiding this post"
      redirect_to members_requests_path
    end
  end
  
  def hide_all_by_household
    @household = Household.find(params[:household_hidden_id])
    @hidden_request = HiddenRequest.new
    @hidden_request.household_hidden_id = params[:household_hidden_id]
    @hidden_request.household = current_user.household
    
    for request in Request.all
      if request.household.id = @hidden_request.household_hidden_id
        for hidden_request in HiddenRequest.all
          if request.id = hidden_request.request_id && hidden_request.household == current_user.household
            hidden_request.destroy
          end
        end
      end
    end
    
    if @hidden_request.save
      flash[:success] = "You have hidden all by #{@household}"
      redirect_to members_requests_path
    else
      flash[:error] = "There was an error hiding requests from this household"
      redirect_to members_requests_path
    end
  end
end
