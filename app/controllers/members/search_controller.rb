class Members::SearchController < Members::MembersController
  
  def index
    unless params[:search ] == ""
      params[:search].downcase
      @households = Household.search(params[:search])
      @households.delete_if { |household| household.id.eql? current_user.household_id } unless @households.eql? nil
      for household in @households
        household.name.downcase
      end
      @users = User.search(params[:search])
      @users.delete_if { |user| user.id.eql? current_user.id} unless @users.eql? nil
    end
  end
end