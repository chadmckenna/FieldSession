module ProfileHelper
  def get_request_household(pending_request)
    return Household.find(pending_request.belongs_to_household_id)
  end
  
  def get_caregiver(user)
    return User.find(user)
  end
end