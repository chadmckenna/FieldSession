# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def google_webfont_stylesheet(face)
    "<link rel=\"stylesheet\" type=\"text/css\" href=\"http://fonts.googleapis.com/css?family=#{face}\" />"
  end
  
  def userbar(user)
    if user
      render :partial => 'layouts/userbar'
    else
      render :partial => 'layouts/loginbar'
    end
  end
  
  def menubar(user)
    render :partial => 'layouts/menubar' if user
  end
  
  def admin_menu_items(user)
    render :partial => 'layouts/admin_menu_items' if user.is_admin?
  end
end
