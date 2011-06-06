class UserMailer < ActionMailer::Base
  
  def welcome_email(user)
    subject     "Welcome to Villages!"
    from        "Villages <do-not-reply@fieldsession.heroku.com>"
    recipients  user.email
    sent_on     Time.now
    body        (:username => user.username, :email => user.email) 
  end
end
