class HomeController < ApplicationController
  skip_before_filter :require_household

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

