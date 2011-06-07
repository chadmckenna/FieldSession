module SearchHelper
  def neighbor(household)
    @neighbors = Neighbor.find(:all, :conditions => {:household_id => current_user.household.id})
    for neighbor in @neighbors
      if neighbor.neighbor == household
        return true
      end
    end
    return false
  end
end