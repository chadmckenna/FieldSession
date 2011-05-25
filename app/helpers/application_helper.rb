# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def google_webfont_stylesheet(face)
    "<link rel=\"stylesheet\" type=\"text/css\" href=\"http://fonts.googleapis.com/css?family=#{face}\" />"
  end
end
