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
    @request.user = current_user
    if @request.save
      flash[:notice] = "Successfully created request."
      redirect_to members_request_path(@request)
    else
      render :action => 'new'
    end
  end

  def edit
    @request = Request.find(params[:id])
  end

  def update
    @request = Request.find(params[:id])
    if @request.update_attributes(params[:request])
      flash[:notice] = "Successfully updated request."
      redirect_to members_request_path(@request)
    else
      render :action => 'edit'
    end
  end

  def destroy
    @request = Request.find(params[:id])
    @request.destroy
    flash[:notice] = "Successfully destroyed request."
    redirect_to members_requests_url
  end
end
