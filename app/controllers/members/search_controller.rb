class Members::SearchController < Members::MembersController
  
  def index
    @households = []
    households = Household.search(params[:search])
    for household in households do
      @households << household if household.id != current_user.household_id
    end
  end
end