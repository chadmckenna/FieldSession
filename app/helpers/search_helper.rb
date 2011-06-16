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
  
  def find_plural(num)
    if num > 1 || num == 0
      return "were"
    else
      return "was"
    end
  end
end