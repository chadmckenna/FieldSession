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
	  	subject		"so and so has requested to be part of your village"
	  	from 		"Village <do-no-reply@fieldsession.heroku.com>"
	  	recipients	user.email
	  	sent_on 	Time.now
	  	body		"testing"
	end
  end
end
