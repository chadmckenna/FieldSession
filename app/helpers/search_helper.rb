module SearchHelper
  def neighbor(household)
    @neighbors = Neighbor.find(:all, :conditions => {:household_id => current_user.household.id, :neighbor_confirmed => 't', :household_confirmed => 't'})
    for neighbor in @neighbors
      if neighbor.neighbor == household
        return true
      end
    end
    return false
  end
  
  def pending_neighbor(household)
    @neighbors = Neighbor.find(:all, :conditions => {:household_id => current_user.household.id, :neighbor_confirmed => 'f', :neighbor_id => household.id})
    if @neighbors.count > 0
      return true
    end
    return false
  end
  
  def get_pending_neighbor(household)
    return Neighbor.find(:last, :conditions => {:household_id => current_user.household.id, :neighbor_confirmed => 'f', :neighbor_id => household.id})
  end
  
  def get_neighbor(household)
    return Neighbor.find(:last, :conditions => {:household_id => current_user.household.id, :neighbor_confirmed => 't', :neighbor_id => household.id})
  end
  
  def find_plural(num)
    if num > 1 || num == 0
      return "were"
    else
      return "was"
    end
  end
  
  def all_neighbors
    unless params[:search ].blank?
      @neighbors = Neighbor.find(:all, :conditions => {:household_id => current_user.household.id})
      @households = Household.search(params[:search])
      @households.delete_if { |household| household.id.eql? current_user.household_id } unless @households.eql? nil
      @users = User.search(params[:search])
      @users.delete_if { |user| user.id.eql? current_user.id} unless @users.eql? nil
      @users.delete_if { |user| user.household.id.eql? current_user.household.id } unless @users.eql? nil
    else
      if !current_user.has_household?
        #flash[:error] = "Please search for a household"
        unless params[:search].blank?
          @households = Household.search(params[:search])
          @users = User.search(params[:search])
        end
      else
      end
    end

    #@flag = false unless @users.count == 0
    for household in @households
      @stop = false
      for neighbor in @neighbors
        if neighbor.neighbor_id == household.id
          @flag = true
          @stop = true
        else
          @flag = false unless @stop == true
        end
      end
      if @flag == false
        return false
      end
    end
    
    #@flag = false unless @users.count == 0
    for user in @users
      @stop = false
      for neighbor in @neighbors
        if neighbor.neighbor_id == user.household.id
          @flag = true
          @stop = true
        else
          @flag = false unless @stop == true
        end
      end
      if @flag == false
        return false
      end
    end
    return @flag
  end
end