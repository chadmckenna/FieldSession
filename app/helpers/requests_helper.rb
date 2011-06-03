module RequestsHelper
  
  def pending(request)
    @same = false
    for pending_request in @pending_requests
      if pending_request.request_id == request.id
        @same = true
      end
    end
    return @same
  end
  
  def commit(request)
    @same = false
    for confirmed_request in @confirmed_requests
      if confirmed_request.request_id == request.id
        @same = true
      end
    end
    return @same
  end
  
  def confirmed(request)
    for confirmed in @confirmed_requests
      if request.id == confirmed.request_id && confirmed.confirmed == "true"
        return true
      end
    end
    return false
  end
  
  def get_household_volunteer(id)
    return Household.find_by_id(id)
  end
end
