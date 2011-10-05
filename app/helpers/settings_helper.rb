module SettingsHelper
  def find_hidden_household(request)
    @household = Household.find(request.household_hidden_id)
    return @household
  end
end