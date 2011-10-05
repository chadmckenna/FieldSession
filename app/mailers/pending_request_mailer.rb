class PendingRequestMailer < ActionMailer::Base

	def request_volunteered_email(pending_request, user)
		volunteer = User.find(:all, :conditions => {:id => pending_request.caregiver_requestor_id})
		request = Request.find(pending_request.request_id)
		
		subject		"Your request has a volunteer"
		from       	"Villages <do-not-reply@fieldsession.heroku.com>"
		recipients	user.email
		sent_on		Time.now
		body		(:caregiver => volunteer, :request_title => request.title, :request_date => request.from_date, :request_time => request.start_time)	
	end

	def volunteer_confirmed_email(pending_request)
		user = User.find(pending_request.caregiver_commit_id)
		request = Request.find(pending_request.request_id)
		household = Household.find(pending_request.belongs_to_household_id)
		from       	"Villages <do-not-reply@fieldsession.heroku.com>"
		subject		"Your volunteer request to watch #{household.name}'s kids has been confirmed"
		recipients	user.email
		sent_on		Time.now
		body		(:household_name => household.name, :request_title => request.title, :request_date => request.from_date, :request_start_time => request.start_time, :request_end_time => request.end_time)
		
	end
end
