module HouseholdsHelper
  def has_volunteered(request)
    @pending_requests = PendingRequest.find(:all, :conditions => {:caregiver_commit_id => current_user.id, :request_id => request.id})
    if @pending_requests.count > 0
      return true
    else
      return false
    end
  end
end
