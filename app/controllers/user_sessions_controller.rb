class UserSessionsController < ApplicationController
  skip_before_filter :require_user
  skip_before_filter :require_household
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => :destroy

  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:success] = "Login successful."
      uri = session[:original_uri]
      session[:original_uri] = nil
      redirect_to (uri || home_url_for(UserSession.find.user))
    else
      render :action => :new
    end
  end

  def destroy
    current_user_session.destroy
    flash[:success] = "You have successfully logged out."
    redirect_to root_url
  end

  protected
    def set_previous_page
      @session[:old_uri] = request.request_uri
    end

end
