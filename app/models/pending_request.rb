class PendingRequest < ActiveRecord::Base
  belongs_to :household
  belongs_to :request
  
  before_create :assign_default_status
  
  def send_request_volunteered_email(users)
    for user in users
      PendingRequestMailer.deliver_request_volunteered_email(self, user)
    end
  end

  def send_volunteer_confirmed_email
    PendingRequestMailer.deliver_volunteer_confirmed_email(self)
  end

  protected
    def assign_default_status
      self.pending = "true"
      self.confirmed = "false"
    end
end
