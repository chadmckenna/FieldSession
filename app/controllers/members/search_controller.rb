class Members::SearchController < Members::MembersController
  
  def index
    @households = Household.search(params[:search])
    @users = User.search(params[:search])

  end
end