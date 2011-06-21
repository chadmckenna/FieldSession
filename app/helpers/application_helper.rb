# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def google_webfont_stylesheet(face)
    "<link rel=\"stylesheet\" type=\"text/css\" href=\"http://fonts.googleapis.com/css?family=#{face}\" />"
  end

  def userbar(user)
    unless user
      render :partial => 'layouts/loginbar'
    end
  end

  def menubar(user)
    render :partial => 'layouts/menubar' if user
  end

  def admin_menu_items(user)
    render :partial => 'layouts/admin_menu_items' if user.is_admin?
  end

  def footer
    render :partial => 'layouts/footer'
  end

  def default_text(text)
     onFocusFunction = "field = event.target || event.srcElement; if (field.value=='#{text}') {field.value = '';}else {return false}"
     onBlurFunction = "field = event.target || event.srcElement; if (field.value=='') {field.value = '#{text}';}else {return false}"
     {:value => text, :onfocus => onFocusFunction, :onblur => onBlurFunction}
  end

  # YJB
  # So much of this stuff belongs in the model. You're programming to the "webapp" domain instead of the "caregiver" domain.
  # That's like focusing on plumbing instead of washing the vegetables you'd like to cook.

  def has_requests(user)
    @num = get_pending_requests_count(user)
    if @num > 0
      return true
    else
      return false
    end
  end

  def has_neighbors(user)
    @num = get_neighbor_request_count(user)
    if @num > 0
      return true
    else
      return false
    end
  end

  def has_caregivers(user)
    @num = get_caregiver_request_count(user)
    return true if @num > 0
    return false
  end

  def get_caregiver_request_count(user)
    return User.find(:all, :conditions => {:household_id => user.household_id, :household_confirmed => false}).count
  end

  def get_neighbor_request_count(user)
    return Neighbor.find(:all, :conditions => {:household_id => user.household.id, :household_confirmed => "f"}).count
  end

  def get_pending_requests_count(user)
    num_volunteer_requests = 0
    volunteer_requests = PendingRequest.find(:all, :conditions => {:belongs_to_household_id => current_user.household.id, :pending => "true"})
    for volunteer_request in volunteer_requests
      requests = PendingRequest.find(:all, :conditions => {:request_id => volunteer_request.request_id})
      count = 0
      for request in requests
        count += 1 if request.confirmed.eql? "true"
      end
      num_volunteer_requests += 1 if count.eql? 0
    end

    return num_volunteer_requests
  end

  def has_accepted_neighbor_request(user)
    @neighbors = Neighbor.find(:all, :conditions => {:household_id => user.household.id, :household_confirmed => "t", :neighbor_confirmed => "t", :read => "f"})
    if @neighbors.count > 0
      return true
    else
      return false
    end
  end

  def get_neighbors_confirmed(user)
    return Neighbor.find(:all, :conditions => {:household_id => user.household.id, :household_confirmed => "t", :neighbor_confirmed => "t", :read => "f"})
  end

  def get_neighbors_confirmed_count(user)
    return get_neighbors_confirmed(user).count
  end

  def get_users_confirmed_requests(user)
    return PendingRequest.find(:all, :conditions => {:caregiver_commit_id => user.id, :confirmed => "true", :read => 'f'})
  end

  def get_caregiver_requests(user)
    return User.find(:all, :conditions => {:household_id => user.household_id, :household_confirmed => false})
  end

  def get_notifications(user)
    @notifications = get_neighbors_confirmed(user)
    @pending_requests = get_users_confirmed_requests(user)
    @caregiver_requests = get_caregiver_requests(user)
    for pending_request in @pending_requests
      @notifications << pending_request
    end
    for caregiver_request in @caregiver_requests
      @notifications << caregiver_request
    end

    return @notifications
  end

  def get_notifications_count(user)
    return get_notifications(user).count
  end

  def get_user(id)
    return User.find(id)
  end

  def get_household(id)
    return Household.find(id)
  end

  # YJB: Nice, a magic mixin just floating around in your controller, just waiting to spring its behavior on
  #      the unsuspecting teammate. Like a zombie, but worse. This belongs in it's own file in /lib.
  module ActionView
    module Helpers
      module DateHelper
        def select_hour(datetime, options = {})
          val = datetime ? (datetime.kind_of?(Fixnum) ? datetime : datetime.hour) : ''
          if options[:use_hidden]
            hidden_html(options[:field_name] || 'hour', val, options)
          else
            hour_options = []
            0.upto(23) do |hour|
              unit = hour < 12 ? :am : :pm
              selected = "selected='selected'" if val == hour
              value = leading_zero_on_single_digits hour
              hr = leading_zero_on_single_digits( unit == :am ? hour : (hour - 12) )
              hr = '12' if hr == '00'
              hour_options << %(<option value="#{ value }" #{ selected }>#{ hr }#{ unit }</option>\n)
            end
            select_html(options[:field_name] || 'hour', hour_options, options)
          end
        end
      end
    end
  end

end

