class Members::SearchController < Members::MembersController
  
  def index
    @households = Household.search(params[:search])
    @households.delete_if { |household| household.id.eql? current_user.household_id }
  end
end