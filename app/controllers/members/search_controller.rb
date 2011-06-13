class Members::SearchController < Members::MembersController
  skip_before_filter :require_household
  
  def index
    unless params[:search ].blank?
      @households = Household.search(params[:search])
      @households.delete_if { |household| household.id.eql? current_user.household_id } unless @households.eql? nil
      @users = User.search(params[:search])
      @users.delete_if { |user| user.id.eql? current_user.id} unless @users.eql? nil
    else
      if !current_user.has_household?
        flash[:error] = "Please search for a household"
        unless params[:search].blank?
          @households = Household.search(params[:search])
          @users = User.search(params[:search])
        end
      end
    end
  end
end
