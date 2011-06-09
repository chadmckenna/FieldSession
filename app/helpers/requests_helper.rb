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
  
  def hidden_request(request)
    for hidden_request in @hidden_requests
      if hidden_request.household_hidden_id == request.household.id
        return true
      elsif hidden_request.request_id == request.id
        return true
      end
    end
    return false
  end
  
  def check_volunteer_count(request)
    @count = 0
    for volunteer in @volunteer_requests
      if volunteer.request_id == request.id
        @count = @count + 1
      end
    end
    return @count
  end
  
  def check_neighbor(request)
    @flag = false
    @neighbors = Neighbor.find(:all, :conditions => {:household_id => current_user.household_id, :household_confirmed => true, :neighbor_confirmed => true})
    for neighbor in @neighbors
      if neighbor.neighbor == request.household
        return true
      end
    end
    return false
  end
end
