class UsersController < ApplicationController
  skip_before_filter :require_household, :require_address
  before_filter :require_no_user, :only => [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    respond_to do |format|
      if @user.save
        @user.send_welcome_email
        flash[:success] = "You've successfully created your user profile! Now let's make your household."
        format.html { redirect_to new_members_household_path }
        format.xml { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

end
