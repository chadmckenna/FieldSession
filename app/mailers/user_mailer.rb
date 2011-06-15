class UserMailer < ActionMailer::Base
  
  def welcome_email(user)
    subject     "Welcome to Villages!"
    from        "Villages <do-not-reply@fieldsession.heroku.com>"
    recipients  user.email
    sent_on     Time.now
    body        (:username => user.username, :email => user.email) 
  end

  def neighbor_request_email(neighbor, user)
  	#@users = User.find(:all, :conditions => {:household_id => neighbor.neighbor_id})
  	#for user in @users
  	subject		   "You have a neighbor request"
  	from   		   "Village <do-no-reply@fieldsession.heroku.com>"
  	recipients	 user.email
  	sent_on 	   Time.now
  	household_name = Household.find(:all, :conditions => {:id => neighbor.household_id})
  	body		     (:username => user.username, :neighbor => household_name)
  	#end
  end

  def neighbor_confirmation_email(neighbor, user)
    #@users = User.find(:all, :conditions => {:household_id => neighbor.neighbor_id})
    @neighbor_household = Household.find(neighbor.neighbor_id)
    #for user in @users
    subject     "You've been Confirmed as a neighbor"
    from        "Village <do-no-reply@fieldsession.heroku.com>"
    recipients  user.email
    sent_on     Time.now
    household_name = Household.find(:all, :conditions => {:id => neighbor.household_id})
    body        (:neighbor_name => @neighbor_household.name)
    #end
  end

  def household_join_request_email(user, household_user)
    subject    "Your household has a caregiver join request"
    from       "Village <do-no-reply@fieldsession.heroku.com>"
    recipients household_user.email
    sent_on    Time.now
    body       (:requestor_f_name => user.first_name, :requestor_l_name => user.last_name)
  end

  def household_join_confirmation_email(user)
    @household = Household.find(user.household_id)
    subject     "Your household join request has be accepted!"
    from        "Villages <do-not-reply@fieldsession.heroku.com>"
    recipients  user.email
    sent_on     Time.now
    body        (:username => user.username, :household_name => @household.name) 
  end
  
  def confirmed_request_change_email(request, pending_request, user)
    subject     "The #{request.household.name} Household has changed the times of their request"
    from        "Villages <do-not-reply@fieldsession.heroku.com>"
    recipients  user.email
    sent_on     Time.now
    body        (:recipient_username => user.username, :changing_household => request.household.name, :request_name => request.title,
                 :request_start_time => request.start_time, :request_end_time => request.end_time, :request_cost => request.cost)
  end
end
