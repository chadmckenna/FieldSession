module ProfileHelper
  def get_request_household(pending_request)
    return Household.find(pending_request.belongs_to_household_id)
  end
end