class Members::ProfileController < Members::MembersController
  def index
    @requests = Request.find_all_by_user_id(current_user.id)
  end
end