class Members::RequestsController < Members::MembersController
  def index
    @requests = Request.find(:all, :order => 'created_at').reverse
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
