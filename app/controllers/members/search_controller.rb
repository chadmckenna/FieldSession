class Members::SearchController < Members::MembersController
  
  def index
    @households = Household.search(params[:search])
  end
end