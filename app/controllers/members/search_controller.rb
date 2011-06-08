class Members::SearchController < Members::MembersController
  
  def index
    unless params[:search ].blank?
      @households = Household.search(params[:search])
      @households.delete_if { |household| household.id.eql? current_user.household_id } unless @households.eql? nil
      @users = User.search(params[:search])
      @users.delete_if { |user| user.id.eql? current_user.id} unless @users.eql? nil
    else
      flash[:error] = "You have entered a blank search. Please try again"
    end
  end
end