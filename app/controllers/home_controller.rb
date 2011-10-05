class HomeController < ApplicationController
  skip_before_filter :require_household, :require_user
  skip_before_filter :require_address

  def index
  end

  def vision
    respond_to do |format|
      format.html
      format.xml  {render :xml}
    end
  end
  
  def how_it_works
    
  end
end

