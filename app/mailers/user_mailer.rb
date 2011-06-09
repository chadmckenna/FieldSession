class UserMailer < ActionMailer::Base
  
  def welcome_email(user)
    subject     "Welcome to Villages!"
    from        "Villages <do-not-reply@fieldsession.heroku.com>"
    recipients  user.email
    sent_on     Time.now
    body        (:username => user.username, :email => user.email) 
  end

  def neighbor_request_email(neighbor)
  	@users = User.find(:all, :conditions => {:household_id => neighbor.neighbor_id})
	for user in @users
	  	subject		"You have a neighbor request"
	  	from 		"Village <do-no-reply@fieldsession.heroku.com>"
	  	recipients	user.email
	  	sent_on 	Time.now
	  	household_name = Household.find(:all, :conditions => {:id => neighbor.household_id})
	  	body		(:username => user.username, :neighbor => household_name)
	end
  end
end
