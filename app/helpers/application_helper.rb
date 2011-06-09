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
  
  def default_text(text)  
     onFocusFunction = "field = event.target || event.srcElement; if (field.value=='#{text}') {field.value = '';}else {return false}"  
     onBlurFunction = "field = event.target || event.srcElement; if (field.value=='') {field.value = '#{text}';}else {return false}"  
     {:value => text, :onfocus => onFocusFunction, :onblur => onBlurFunction}   
  end
  
  def has_requests(user)
    @num = PendingRequest.find_all_by_belongs_to_household_id(user.household.id).count
    if @num > 0
      return true
    end
    return false
  end
  
  def has_neighbors(user)
    @num = Neighbor.find(:all, :conditions => {:household_id => user.household.id, :household_confirmed => "f"}).count
    if @num > 0
      return true
    else
      return false
    end
  end
  
  def get_neighbor_request_count(user)
    return Neighbor.find(:all, :conditions => {:household_id => user.household.id, :household_confirmed => "f"}).count
  end
  
  def get_pending_requests_count(user)
    return PendingRequest.find(:all, :conditions => {:belongs_to_household_id => user.household.id, :pending => "true"}).count
  end
  
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

