module SearchHelper
  def neighbor(household)
    @neighbors = Neighbor.find_all_by_household_id(current_user.household.id)
    for neighbor in @neighbors
      if neighbor.neighbor_id == household.id
        return true
      end
    end
    return false
  end
end