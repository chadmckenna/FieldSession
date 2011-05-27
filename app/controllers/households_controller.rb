class HouseholdsController < ApplicationController
  def index
    @households = Household.all
    @users = User.find_all_by_household_id(current_user.household.id)
    @requests = @users.requests.all
  end

  def show
    @household = Household.find(params[:id])
  end

  def new
    @household = Household.new
  end

  def create
    @household = Household.new(params[:household])
    if @household.save
      flash[:notice] = "Successfully created household."
      redirect_to @household
    else
      render :action => 'new'
    end
  end

  def edit
    @household = Household.find(params[:id])
  end

  def update
    @household = Household.find(params[:id])
    if @household.update_attributes(params[:household])
      flash[:notice] = "Successfully updated household."
      redirect_to @household
    else
      render :action => 'edit'
    end
  end

  def destroy
    @household = Household.find(params[:id])
    @household.destroy
    flash[:notice] = "Successfully destroyed household."
    redirect_to households_url
  end
end

