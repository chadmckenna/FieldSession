class Members::ProfileController < Members::MembersController
  def index
    @my_requests = Request.find_all_by_user_id(current_user.id)
    @household = current_user.household
  end
end